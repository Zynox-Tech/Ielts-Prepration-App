import json

def convert_vocab():
    try:
        with open('assets/model/vocab.json', 'r', encoding='utf-8') as f:
            vocab = json.load(f)
        
        # Sort by ID to ensure correct order if we use line number as ID
        # or just write "token id" per line
        sorted_vocab = sorted(vocab.items(), key=lambda item: item[1])
        
        with open('assets/model/vocab.txt', 'w', encoding='utf-8') as f:
            for token, idx in sorted_vocab:
                # Escape newlines in tokens if any
                token = token.replace('\n', '\\n')
                f.write(f"{token} {idx}\n")
                
        print(f"Converted {len(sorted_vocab)} tokens to assets/model/vocab.txt")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    convert_vocab()
