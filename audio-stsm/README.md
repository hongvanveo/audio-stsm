# audio-stsm

Lab nay yeu cau sinh vien thuc hien nhung tin vao audio bang phuong phap STSM sau khi tu tao thong diep va sua mot doan code Python mau.

Co che:

- Thong diep duoc them header `STSM` va do dai.
- Moi 4 bit thong tin duoc ma hoa thanh tu ma Hamming 7 bit.
- Moi bit sau ma hoa duoc nhung vao 3 mau am thanh.
- Neu bit can nhung la 1 thi tong 3 mau phai le.
- Neu bit can nhung la 0 thi tong 3 mau phai chan.

Cau truc lab:

- Lab chi dung 1 container duy nhat ten `audio-stsm`.
- Sinh vien thao tac trong thu muc `~/stego`.
- File `embed_task.py` la file can sua de dien ten file audio va ten file thong diep.

Luong thuc hanh:

```bash
cd ~/stego
python3 generate_cover.py --out cover.wav
nano message.txt
nano embed_task.py
python3 embed_task.py
python3 analyze_audio.py --cover cover.wav --stego stego.wav
cmp cover.wav stego.wav
```

Checkwork co 3 muc:

- `cover_created`
- `stego_created`
- `samples_modified`
