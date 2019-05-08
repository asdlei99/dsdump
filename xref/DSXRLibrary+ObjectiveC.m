//
//  DSXRLibrary+ObjectiveC.m
//  xref
//
//  Created by Derek Selander on 4/29/19.
//  Copyright © 2019 Selander. All rights reserved.
//

#import "DSXRLibrary+ObjectiveC.h"
#import "DSXRLibrary+SymbolDumper.h"
#include <libgen.h>


#define FAST_DATA_MASK          0x00007ffffffffff8UL

typedef struct  {
    uint16_t mod_off : 16;
    uint16_t mod_len : 16;
    uint16_t cls_off : 16;
//    uint16_t cls_len : 10;
    BOOL success : 1;
} d_offsets;

@implementation DSXRLibrary (ObjectiveC)

- (void)dumpObjectiveCClasses {
    // Defined symbols, will go after the __DATA.__objc_classlist pointers
    if (xref_options.defined || !(xref_options.undefined || xref_options.defined)) {
        
        struct section_64* class_list = [self.sectionCommandsDictionary[@"__DATA.__objc_classlist"]
                                         pointerValue];

        if (class_list) {
            uintptr_t offset = [self translateLoadAddressToFileOffset:class_list->addr useFatOffset:NO] + self.file_offset;
            uintptr_t *buff = (uintptr_t *)&self.data[offset];
            char modname[1024];
            for (int i = 0; i < class_list->size / PTR_SIZE; i++) {
                if (xref_options.swift_mode && ![self isSwiftClass:buff[i]]) {
                    continue;
                }
                
                const char *name = [self nameForObjCClass:buff[i]];
                d_offsets off;
                if (xref_options.swift_mode && [self demangleSwiftName:name offset:&off]) {
                    strncpy(modname, &name[off.mod_off], off.mod_len);
                    modname[off.mod_len] = '\00';
                    printf("0x%011lx %s%s.%s%s", buff[i],  dcolor(DSCOLOR_CYAN), modname, &name[off.cls_off], color_end());

                } else {
          
                    printf("0x%011lx %s%s%s", buff[i],  dcolor(DSCOLOR_CYAN), name, color_end());
                }

                DSXRObjCClass *objcReference;
                if (xref_options.verbose > VERBOSE_NONE) {
                    // Check if it's an external symbol first via the dylds binding opcodes....
                    objcReference = self.addressObjCDictionary[@(buff[i] + PTR_SIZE)];
                    const char *name = objcReference.shortName.UTF8String;
                    
                    char *color = dcolor(DSCOLOR_GREEN);
                                        
                    if (!name) {
                        offset = [self translateLoadAddressToFileOffset:buff[i] + PTR_SIZE useFatOffset:NO];
                        uintptr_t supercls = *(uintptr_t *)&self.data[offset + self.file_offset];
                        
                        if (supercls) {
                            name = [self nameForObjCClass:supercls];
                            color = dcolor(DSCOLOR_MAGENTA);
                        }
                    }
                    color = name ? color : dcolor(DSCOLOR_RED);
                    if (xref_options.swift_mode && [self demangleSwiftName:name offset:&off]) {
                        strncpy(modname, &name[off.mod_off], off.mod_len);
                        modname[off.mod_len] = '\00';
                        printf(" : %s%s%s%s", color, modname, &name[off.cls_off], color_end());
                    } else {
                        printf(" : %s%s%s", color, name ? name : "<ROOT>", color_end());
                    }
                }
                
                if (xref_options.verbose > VERBOSE_2) {
                    char *libName = objcReference && objcReference.libOrdinal ? (char*)self.depdencies[objcReference.libOrdinal].UTF8String : NULL;
                    if (libName) {
                        printf(" %s%s%s", dcolor(DSCOLOR_YELLOW), libName, color_end());
                    }
                }
                
                putchar('\n');
            }
            
       
        }
    }
    
    // Undefined symbols, use the symbol table
    struct nlist_64 *symbols = self.symbols;
    if (xref_options.undefined || !(xref_options.undefined || xref_options.defined)) {
        for (int i = self.dysymtab->iundefsym; i < self.dysymtab->nundefsym + self.dysymtab->iundefsym; i++) {
            struct nlist_64 sym = symbols[i];
            char *chr = &self.str_symbols[sym.n_un.n_strx];
            
            if (!strnstr(chr, "_OBJC_CLASS_$_", OBJC_CLASS_LENGTH)) {
                continue;
            }
//            NSString *name = [NSString stringWithUTF8String:chr];
//            uintptr_t addr = self.stringObjCDictionary[name].address.unsignedLongValue;
            print_symbol(self, &sym, NULL);
        }
    }
}

-(const char *)nameForObjCClass:(uintptr_t)address {
    // Going after the class_ro_t of an ObjectiveC class
    // ommitting using Apple headers since their legal agreement is a PoS
    // On disk, class_ro_t seems to be stored at class_rw_t, so flip those around while on disk...
    
    uintptr_t offset = [self translateLoadAddressToFileOffset:address useFatOffset:NO ] + self.file_offset;
    // Starts at __DATA.__objc_data, translate to file offset, going after class_rw_t 8
    if (!(offset )) {
        return NULL;
    }
    
    // Grab the  the class_rw_t data found in __DATA__objc_const, need to apply the FAST_DATA_MASK on the
    // class_data_bits_t since it can be not pointer aligned
//    uintptr_t buff = *(uintptr_t *)DATABUF(offset);
    
    
    
//    if (*(uintptr_t *)((uintptr_t)DATABUF(offset + (4 * PTR_SIZE)))
    uintptr_t buff = *(uintptr_t *)((uintptr_t)DATABUF(offset + (4 * PTR_SIZE)) & FAST_DATA_MASK);
    

    if (!(offset = [self translateLoadAddressToFileOffset:(buff & FAST_DATA_MASK) useFatOffset:NO])) {
        return NULL;
    }
    

    buff = *(uintptr_t *)DATABUF(offset + self.file_offset + (3 * PTR_SIZE));
    if (!buff) {
        return NULL;
    }
    
    // transform it into file offset and deref...
    if (!(offset = [self translateLoadAddressToFileOffset:buff useFatOffset:NO])) {
        return NULL;
    }
    
    char *s = (void*)&self.data[offset + self.file_offset];
    if (strlen(s)) {
        return s;
    }
    return NULL;
}


-(BOOL)isSwiftClass:(uintptr_t)address {

    uintptr_t offset = [self translateLoadAddressToFileOffset:address useFatOffset:NO ] + self.file_offset;
    if (!(offset)) {
        return NO;
    }
    
#define FAST_IS_SWIFT_LEGACY 1
#define FAST_IS_SWIFT_STABLE 2
    
    uintptr_t buff = (*(uintptr_t *)DATABUF(offset + (4 * PTR_SIZE)));
    
    return buff & (FAST_IS_SWIFT_LEGACY|FAST_IS_SWIFT_STABLE) ? YES : NO;
}

- (BOOL)demangleSwiftName:(const char *)name offset:(d_offsets *)f {

//    "_TtC9SwiftTest14ViewController"
    if (!name || strlen(name) == 0) {
        f->success = NO;
        return NO;
    }
    if (!strnstr(name, "_TtC", 4)) {
        f->success = NO;
        return NO;
    }
    
    
    int index = strlen("_TtC");
    f->mod_off = index;
    while (name[index] >= '0' && name[index] <= '9') {
        index++;
    }
    char md_len[5] = {};
    strncpy(md_len, &name[f->mod_off], index - f->mod_off);
    f->mod_len = atoi(md_len);
    
    index += f->mod_len ;
    while (name[index] >= '0' && name[index] <= '9') {
        index++;
    }
    f->cls_off = index;
    f->mod_off++;
    return YES;
}

@end
