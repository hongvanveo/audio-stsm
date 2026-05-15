# audio-stsm

Labtainer lab ve giau tin trong am thanh bang phuong phap dieu chinh ti le thoi gian STSM.

Co che:

- Thong diep duoc them header `STSM` va do dai.
- Moi 4 bit thong tin duoc ma hoa thanh tu ma Hamming 7 bit.
- Moi bit sau ma hoa duoc nhung vao 3 mau am thanh.
- Neu bit can nhung la 1 thi tong 3 mau phai le.
- Neu bit can nhung la 0 thi tong 3 mau phai chan.
- Neu chua dung dieu kien, chuong trinh dieu chinh nhe mot mau trong nhom.

Lenh mau trong container `sender`:

```bash
cd ~/stego
python3 generate_cover.py --out cover.wav
python3 stsm_stego.py embed --in cover.wav --out stego.wav --message samples/message.txt
python3 stsm_stego.py extract --in stego.wav --out recovered.txt
python3 analyze_audio.py --cover cover.wav --stego stego.wav
```

Checkwork co 4 muc trong `instr_config/results.config`.

