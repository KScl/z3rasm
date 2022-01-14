import bsdiff4
import yaml
import lzma
import hashlib
from typing import Optional

try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader

JPN10HASH = '03a63945398191337e896e5771f77173'

def generate_yaml(patch: bytes, metadata: Optional[dict] = None) -> bytes:
    patch = yaml.dump({"meta": metadata,
                       "patch": patch,
                       "game": "alttp",
                       "base_checksum": JPN10HASH})
    return patch.encode(encoding="utf-8-sig")
    
def generate_patch(baserombytes: bytes, rom: bytes) -> bytes:
    patch = bsdiff4.diff(bytes(baserombytes), bytes(rom))
    return generate_yaml(patch, {})
    
def write_lzma(data: bytes, path: str):
    with lzma.LZMAFile(path, 'wb') as f:
        f.write(data)

def dump_lzma(path: str, dump_path: str):
    dump = open(dump_path, 'wb')
    with lzma.LZMAFile(path, 'rb') as f:
        dump.write(f.read())

if __name__ == '__main__':
    with open('inp/z3.sfc', 'rb') as stream:
        old_rom_data = bytearray(stream.read())
    with open('out/baserom.sfc', 'rb') as stream:
        new_rom_data = bytearray(stream.read())
    basemd5 = hashlib.md5()
    basemd5.update(new_rom_data)
    print("New Rom Hash: " + basemd5.hexdigest())
    write_lzma(generate_patch(old_rom_data, new_rom_data), "out/basepatch.bmbp")
