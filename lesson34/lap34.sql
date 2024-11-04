use Lab32_QLSV_TVC
/*III*/
/*Bài 3*/
-- 1. Trung bình điểm thi theo từng môn
SELECT 
    mh.MaMH,
    mh.TenMH,
    AVG(kq.Diem) AS TrungBinhDiemThi
FROM 
    Ketqua kq
JOIN 
    MonHoc mh ON kq.MaMH = mh.MaMH
GROUP BY 
    mh.MaMH, mh.TenMH;

-- 2. Danh sách số môn thi của từng sinh viên
SELECT 
    sv.HoSV + ' ' + sv.TenSV AS HoTenSinhVien,
    k.TenKH AS TenKhoa,
    COUNT(kq.MaMH) AS TongSoMonThi
FROM 
    SinhVien sv
JOIN 
    Khoa k ON sv.MaKH = k.MaKH
JOIN 
    Ketqua kq ON sv.MaSV = kq.MaSV
GROUP BY 
    sv.HoSV, sv.TenSV, k.TenKH;

-- 3. Tổng điểm thi của từng sinh viên
SELECT 
    sv.TenSV AS TenSinhVien,
    k.TenKH AS TenKhoa,
    sv.Phai AS Phai,
    SUM(kq.Diem) AS TongDiemThi
FROM 
    SinhVien sv
JOIN 
    Khoa k ON sv.MaKH = k.MaKH
JOIN 
    Ketqua kq ON sv.MaSV = kq.MaSV
GROUP BY 
    sv.TenSV, k.TenKH, sv.Phai;

-- 4. Tổng số sinh viên ở mỗi khoa
SELECT 
    k.TenKH AS TenKhoa,
    COUNT(sv.MaSV) AS TongSoSinhVien
FROM 
    Khoa k
JOIN 
    SinhVien sv ON k.MaKH = sv.MaKH
GROUP BY 
    k.TenKH;

-- 5. Điểm cao nhất của mỗi sinh viên
SELECT 
    sv.HoSV + ' ' + sv.TenSV AS HoTenSinhVien,
    MAX(kq.Diem) AS DiemCaoNhat
FROM 
    SinhVien sv
JOIN 
    Ketqua kq ON sv.MaSV = kq.MaSV
GROUP BY 
    sv.HoSV, sv.TenSV;

-- 6. Thông tin của môn học có số tiết nhiều nhất
SELECT 
    TenMH,
    Sotiet
FROM 
    MonHoc
WHERE 
    Sotiet = (SELECT MAX(Sotiet) FROM MonHoc);

-- 7. Học bổng cao nhất của từng khoa
SELECT 
    k.MaKH,
    k.TenKH,
    MAX(sv.HocBong) AS HocBongCaoNhat
FROM 
    Khoa k
JOIN 
    SinhVien sv ON k.MaKH = sv.MaKH
GROUP BY 
    k.MaKH, k.TenKH;

-- 8. Điểm cao nhất của mỗi môn
SELECT 
    mh.TenMH,
    MAX(kq.Diem) AS DiemCaoNhat
FROM 
    MonHoc mh
JOIN 
    Ketqua kq ON mh.MaMH = kq.MaMH
GROUP BY 
    mh.TenMH;

-- 9. Số sinh viên học của từng môn
SELECT 
    mh.MaMH,
    mh.TenMH,
    COUNT(kq.MaSV) AS SoSinhVienDangHoc
FROM 
    MonHoc mh
JOIN 
    Ketqua kq ON mh.MaMH = kq.MaMH
GROUP BY 
    mh.MaMH, mh.TenMH;

-- 10. Môn có điểm thi cao nhất
SELECT 
    mh.TenMH,
    mh.Sotiet,
    sv.HoSV + ' ' + sv.TenSV AS TenSinhVien,
    kq.Diem
FROM 
    Ketqua kq
JOIN 
    MonHoc mh ON kq.MaMH = mh.MaMH
JOIN 
    SinhVien sv ON kq.MaSV = sv.MaSV
WHERE 
    kq.Diem = (SELECT MAX(Diem) FROM Ketqua);

-- 11. Khoa có đông sinh viên nhất
SELECT 
    k.MaKH,
    k.TenKH,
    COUNT(sv.MaSV) AS TongSoSinhVien
FROM 
    Khoa k
JOIN 
    SinhVien sv ON k.MaKH = sv.MaKH
GROUP BY 
    k.MaKH, k.TenKH
ORDER BY 
    TongSoSinhVien DESC


-- 12. Khoa có sinh viên nhận học bổng cao nhất
SELECT 
    k.TenKH AS TenKhoa,
    sv.HoSV + ' ' + sv.TenSV AS HoTenSinhVien,
    sv.HocBong
FROM 
    SinhVien sv
JOIN 
    Khoa k ON sv.MaKH = k.MaKH
WHERE 
    sv.HocBong = (SELECT MAX(HocBong) FROM SinhVien WHERE MaKH = k.MaKH);
--13.Cho biết sinh viên của khoa Tin học có có học bổng cao nhất, gồm các thông tin:  Mã sinh viên, Họ sinh viên, Tên sinh viên, Tên khoa, Học bổng  
SELECT MaSV,HoSV,TenSV,Khoa.TenKH,HocBong
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH=Khoa.MaKH
WHERE TenKH=N'Tin học' 
AND SinhVien.HocBong = (SELECT MAX(HocBong) FROM SinhVien WHERE MaKH = Khoa.MaKH);
-- Bài 4
/*1. Cho biết danh sách những sinh viên của một khoa, gồm: Mã sinh viên, Họ tên  sinh viên, Giới tính, 
Tên khoa. Trong đó, giá trị mã khoa cần xem danh sách sinh  viên sẽ được người dùng nhập khi thực thi câu truy vấn*/  

DECLARE @MAKH NVARCHAR(10);
SET @MAKH = 'AV'; -- Người dùng sẽ nhập mã khoa tại đây
SELECT 
    sv.MaSV,
    CONCAT(sv.HoSV, ' ', sv.TenSV) AS HoTenSinhVien,
    sv.Phai,
    k.TenKH AS TenKhoa
FROM 
    SinhVien sv
JOIN 
    Khoa k ON sv.MaKH = k.MaKH
WHERE 
    sv.MaKH = @MAKH;
/*2. Liệt kê danh sách sinh viên có điểm môn Cơ sở dữ liệu lớn hơn một giá trị bất  kỳ do người sử dụng nhập vào khi thực thi câu truy vấn
, thông tin gồm: Mã sinh  viên, Họ tên sinh viên, Tên môn, Điểm  */
DECLARE @Diem int;
SET @Diem=5.0;
SELECT
	SinhVien.MaSV as N'Mã Sinh viên',
	SinhVien.HoSV+''+SinhVien.TenSV as N'Họ Và Tên SV',
	MonHoc.TenMH as N'Môn học',
	Ketqua.Diem as N'Điểm'
FROM
	SinhVien
JOIN
	Khoa ON SinhVien.MaKH=Khoa.MaKH
JOIN
	Ketqua ON SinhVien.MaSV=Ketqua.MaSV
JOIN
	MonHoc on Ketqua.MaMH=MonHoc.MaMH
WHERE
	Ketqua.Diem=@Diem;
/*3. Cho kết quả thi của các sinh viên theo môn, tên môn cần xem kết quả sẽ được  nhập vào khi thực thi câu truy vấn.
Thông tin hiển thị gồm: Mã sinh viên, Tên  khoa, Tên môn, Điểm 
*/
DECLARE @TenMH NVARCHAR (30);
SET @TenMH=N'Cơ sở dữ liệu';
SELECT
	 SinhVien.MaSV as N'Mã sinh viên',
	 khoa.TenKH as N'Tên khoa',
	 MonHoc.TenMH as N'Tên môn',
	 Ketqua.Diem as N'Điểm'
FROM
SinhVien
JOIN
khoa on SinhVien.MaKH=Khoa.MaKH
JOIN
Ketqua on SinhVien.MaSV=Ketqua.MaSV
JOIN
MonHoc on Ketqua.MaMH=MonHoc.MaMH
where
MonHoc.TenMH=@TenMH
/*Bài 5: Truy vấn con  
12.Các sinh viên có học bổng cao nhất theo từng khoa, gồm Mã sinh viên, Tên khoa,  Học bổng 
*/

SELECT 
    MaSV as N'Mã sinh viên',
	TenKH as N'Tên Khoa',
	HocBong as N'Học Bổng'
FROM 
    SinhVien sv
JOIN 
    Khoa k ON sv.MaKH = k.MaKH
WHERE 
    sv.HocBong = (
        SELECT 
            MAX(HocBong)
        FROM 
            SinhVien
        WHERE 
            MaKH = sv.MaKH
    )
ORDER BY 
    k.TenKH;

 /*11.Danh sách sinh viên có điểm cao nhất ứng với mỗi môn, gồm thông tin: Mã sinh  viên, Họ tên sinh viên, Tên môn, Điểm  
*/
SELECT 
    kq.MaSV AS N'Mã Sinh viên',
    sv.TenSV+''+sv.HoSV AS N'Họ tên sinh viên',
    mh.TenMH AS N'Tên môn',
    kq.Diem
FROM 
    Ketqua kq
JOIN 
    SinhVien sv ON kq.MaSV = sv.MaSV
JOIN 
    MonHoc mh ON kq.MaMH = mh.MaMH
WHERE 
    kq.Diem = (
        SELECT 
            MAX(Diem)
        FROM 
            Ketqua
        WHERE 
            MaMH = kq.MaMH
    )
ORDER BY 
    mh.TenMH;
--câu 6 bài 8
UPDATE Ketqua
SET Diem = LEAST(Diem + 5, 10)
WHERE MaMH = '02' 
AND EXISTS (
    SELECT 1 
    FROM SinhVien s 
    WHERE s.MaSV = Ketqua.MaSV AND s.MaKH = 'AV'
);

-- câu 7 bài 8
UPDATE SinhVien
SET HocBong = CASE 
                WHEN MaKH = 'AV' AND Phai = '1' THEN HocBong + 100000
                WHEN MaKH = 'TH' AND Phai = '0' THEN HocBong + 150000
                ELSE HocBong + 50000
              END;

-- câu 8 bài 8
UPDATE Ketqua
SET Diem = CASE 
                WHEN sv.MaKH = 'AV' AND mh.TenMH = 'Cơ sở dữ liệu' THEN LEAST(Diem + 2, 10)
                WHEN sv.MaKH = 'TH' AND mh.TenMH = 'Cơ sở dữ liệu' THEN GREATEST(Diem - 1, 0)
                ELSE Diem
              END
FROM Ketqua kqt
JOIN SinhVien sv ON kqt.MaSV = sv.MaSV
JOIN MonHoc mh ON kqt.MaMH = mh.MaMH
WHERE mh.TenMH = 'Cơ sở dữ liệu';
select * from Ketqua
