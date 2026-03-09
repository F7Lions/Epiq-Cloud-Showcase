import hashlib
import sys

def calculate_sha256(file_path):
    sha256_hash = hashlib.sha256()
    try:
        with open(file_path, "rb") as f:
            for byte_block in iter(lambda: f.read(4096), b""):
                sha256_hash.update(byte_block)
        return sha256_hash.hexdigest()
    except FileNotFoundError:
        return "File not found."

if __name__ == "__main__":
    if len(sys.argv) > 1:
        file_to_check = sys.argv[1]
        print(f"--- Legal Bundle Integrity Check ---")
        print(f"File: {file_to_check}")
        print(f"SHA-256 Hash: {calculate_sha256(file_to_check)}")
    else:
        print("Usage: python verify_integrity.py <filename>")