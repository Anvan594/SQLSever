use Lab32_QLSV_TVC
--Bài 1
--câu 1
CREATE VIEW SinhVien_HocBong_Cao_HCM AS
SELECT MaSV, TenSV, HocBong, NoiSinh
FROM SinhVien
WHERE HocBong > 100000 AND NoiSinh LIKE '%HCM%';

SELECT * FROM SinhVien_HocBong_Cao_HCM;
--câu 2
CREATE VIEW Sinhvien_KhoaAnhVan_Triet AS
SELECT MaSV,MaKH,Phai
FROM SinhVien
where MaKH='AV' or MaKH='TR';
SELECT * FROM Sinhvien_KhoaAnhVan_Triet;
--câu 3
CREATE VIEW CAU3 AS
SELECT MaSV,NgaySinh,NoiSinh,HocBong
FROM SinhVien
WHERE NgaySinh BETWEEN '1986-06-05' AND '1992-06-05'
GO
SELECT * FROM CAU3
--CÂU 4
CREATE  VIEW CAU4 AS
SELECT MaSV,NgaySinh,Phai,MaKH
FROM SinhVien
WHERE HocBong BETWEEN 200000 AND 800000
GO
SELECT * FROM CAU4
--CÂU 5
CREATE VIEW CAU5 AS
SELECT MaMH,TenMH,Sotiet
FROM MonHoc
WHERE Sotiet BETWEEN 40 AND 60 
SELECT * FROM CAU5 
-- CÂU 6
CREATE  VIEW CAU6 AS
SELECT MaSV,HoSV+''+TenSV AS [Họ tên sinh viên],
	CASE 
		WHEN Phai = 0 THEN 'NAM'
	END AS PHAI
FROM SinhVien
WHERE Phai=0
GO
SELECT*FROM CAU6
--CAU7
DROP VIEW CAU7
CREATE VIEW CAU7 AS
SELECT HoSV AS[ Họ sinh viên],TenSV[Tên sinh viên],NoiSinh[Nơi sinh],CONVERT(VARCHAR, NgaySinh, 103)AS [Ngày sinh]
FROM SinhVien
WHERE NoiSinh = N'Hà Nội' AND CONVERT(VARCHAR, NgaySinh, 103) > '01/01/1990'
GO

SELECT * FROM CAU7
--câu 8
CREATE VIEW CAU8 AS
SELECT *
FROM Sinhvien
WHERE Phai = 'Nữ' AND TenSV LIKE '%n%';
SELECT * FROM CAU8
--câu 9
CREATE VIEW CAU9 AS
SELECT MaSV, HoSV,TenSV, phai, NgaySinh
FROM SinhVien
WHERE phai = 1
  AND MaKH = 'TinHoc'
  AND NgaySinh > '1986-05-30';

  SELECT * FROM CAU9
  --câu 10
 CREATE VIEW CAU10 AS
  SELECT  HoSV+''+TenSV as[Họ và tên sinh viên], 
       CASE WHEN phai = 1 THEN 'Nam' ELSE 'Nu' END AS GioiTinh, 
       NgaySinh
FROM SinhVien;
SELECT * FROM CAU10
  --câu 11
CREATE VIEW CAU11 AS
SELECT MaSV, HoSV+''+TenSV as[Họ và tên sinh viên], 
       YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, 
       NoiSinh, MaKH
FROM SinhVien;
SELECT * FROM CAU11
--câu 12
CREATE VIEW CAU12 AS
SELECT HoSV+''+TenSV as[Họ và tên sinh viên], Tuoi, TenKH
FROM (
    SELECT HoSV+''+TenSV as[Họ và tên sinh viên], 
           YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, 
           TenKH
    FROM SinhVien
    JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
) AS TuoiTinh,SinhVien
WHERE Tuoi BETWEEN 20 AND 30;
SELECT * FROM CAU12
--CÂU 13
CREATE VIEW CAU13 AS
SELECT MaSV, Phai, MaKH, 
       CASE 
           WHEN HocBong > 500000 THEN 'Muc hoc bong cao'
           ELSE 'Muc hoc bong thap' 
       END AS MucHocBong
FROM SinhVien;
SELECT * FROM CAU13
--CÂU 14
CREATE VIEW CAU14 AS
SELECT  HoSV+''+TenSV as[Họ và tên sinh viên], Phai, TenKH
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.TenKH = N'Anh Văn'
  AND (Phai = 1 OR Phai =0);
  
SELECT * FROM CAU14