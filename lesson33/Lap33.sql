use [Lab32_QLSV_TVC]
go
/*bài 2*/
/*Câu 1*/
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen, 
       CASE WHEN Phai = 1 THEN 'Nam' ELSE N'Nữ' END AS GioiTinh, 
       YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, 
       MaKH AS MaKhoa
FROM SinhVien
ORDER BY Tuoi DESC;
/*Câu 2*/
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen, 
       CASE WHEN Phai = 1 THEN N'Nam' ELSE N'Nữ' END AS Phai, 
       NgaySinh
FROM SinhVien
WHERE MONTH(NgaySinh) = 2 AND YEAR(NgaySinh) = 1994;
/* Câu 3*/
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTen, 
       NgaySinh
FROM SinhVien
ORDER BY NgaySinh DESC;
/* Câu 4*/
SELECT MaSV, 
       CASE WHEN Phai = 1 THEN 'Nam' ELSE N'Nữ' END AS Phai, 
       MaKH AS MaKhoa, 
       CASE WHEN HocBong > 500000 THEN N'Học bổng cao' ELSE N'Mức trung bình' END AS MucHocBong
FROM SinhVien;
/* Câu 5*/
SELECT CONCAT(SinhVien.HoSV, ' ', SinhVien.TenSV) AS HoTen, 
       Ketqua.MaMH, 
       Ketqua.Diem
FROM Ketqua
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
ORDER BY HoTen ASC, MaMH ASC;
/*Câu 6*/
SELECT CONCAT(SinhVien.HoSV, ' ', SinhVien.TenSV) AS HoTen, 
       CASE WHEN Phai = 1 THEN 'Nam' ELSE N'Nữ' END AS GioiTinh, 
       Khoa.TenKH AS TenKhoa
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.TenKH = N'Anh văn';
/*Câu 7*/
SELECT Khoa.TenKH AS TenKhoa, 
       CONCAT(SinhVien.HoSV, ' ', SinhVien.TenSV) AS HoTen, 
       MonHoc.TenMH AS TenMonHoc, 
       MonHoc.Sotiet, 
       Ketqua.Diem
FROM Ketqua
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.TenKH = N'Tin Học';
/*Câu 8*/
SELECT CONCAT(SinhVien.HoSV, ' ', SinhVien.TenSV) AS HoTen, 
       SinhVien.MaKH AS MaKhoa, 
       MonHoc.TenMH AS TenMonHoc, 
       Ketqua.Diem, 
       CASE 
           WHEN Ketqua.Diem > 8 THEN N'Giỏi' 
           WHEN Ketqua.Diem BETWEEN 6 AND 8 THEN N'Khá' 
           ELSE N'Trung Bình' 
       END AS Loai
FROM Ketqua
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH;




