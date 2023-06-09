-- trigger nhân viên
-- 1. KIỂM TRA TÊN NHÂN VIÊN CÓ BỊ TRÙNG KHÔNG
CREATE TRIGGER tg_TENNV_NHANVIEN ON NHANVIEN
FOR INSERT
AS
BEGIN
    DECLARE @TENNV NVARCHAR(100)
    SELECT @TENNV = TENNV FROM INSERTED
    IF ((SELECT COUNT(*) FROM NHANVIEN WHERE @TENNV=TENNV) > 1)
    BEGIN
        RAISERROR (N'TÊN NHÂN VIÊN BỊ TRÙNG',15,1)
        ROLLBACK TRAN
        RETURN 
    END
END
INSERT NHANVIEN VALUES 
(N'NV09',N'Phạm Trương Gia Hân',N'Nữ','2000-09-13',N'265, Nguyễn Trãi, Phường Nguyễn Cư Trinh, Quận 1, Thành phố Hồ Chí Minh',N'Khơ-Me',N'0848046390',N'GiaHan1309@gmail.com',4500000.0,0)

--2. KIỂM TRA NHÂN VIÊN CÓ ĐỦ TUỔI LAO ĐỘNG KHÔNG
CREATE TRIGGER tg_TUOI_NHANVIEN ON NHANVIEN
FOR INSERT
AS
BEGIN
    DECLARE @TUOI INT 
    SELECT @TUOI = DATEDIFF(YEAR, NGAYSINH, GETDATE()) FROM inserted
    IF(@TUOI < 18)
    BEGIN
        RAISERROR (N'NHÂN VIÊN KHÔNG ĐỦ TUỔI', 15, 1)
        ROLLBACK TRAN
        RETURN 
    END 
END
INSERT NHANVIEN VALUES (N'NV09',N'TRUNG TRẦN 123',N'Nữ','2022-09-13',N'265, Nguyễn Trãi, Phường Nguyễn Cư Trinh, Quận 1, Thành phố Hồ Chí Minh',N'Khơ-Me',N'0848046390',N'GiaHan1309@gmail.com',4500000.0,0);

--3. KIỂM TRA SỐ ĐIỆN THOẠI CỦA NHÂN VIÊN CÓ BỊ TRÙNG HAY KHÔNG
CREATE TRIGGER tg_DIENTHOAI_NHANVIEN ON NHANVIEN
FOR INSERT
AS
BEGIN
    DECLARE @DIENTHOAI NVARCHAR(100)
    SELECT @DIENTHOAI = DIENTHOAI FROM INSERTED
    IF ((SELECT COUNT(*) FROM NHANVIEN WHERE @DIENTHOAI=DIENTHOAI) > 1)
    BEGIN
        RAISERROR (N'SỐ ĐIỆN THOẠI CỦA NHÂN VIÊN BỊ TRÙNG',15,1)
        ROLLBACK TRAN
        RETURN 
    END
END
INSERT NHANVIEN VALUES (N'NV09',N'TRUNG TRẦN 123',N'Nữ','2002-09-13',N'265, Nguyễn Trãi, Phường Nguyễn Cư Trinh, Quận 1, Thành phố Hồ Chí Minh',N'Khơ-Me',N'0848046390',N'GiaHan1309@gmail.com',4500000.0,0);

--4. KIỂM TRA THÊM NHÂN VIÊN THÀNH CÔNG
CREATE TRIGGER TG_THEMTG_NHANVIEN ON NHANVIEN
FOR INSERT 
AS
BEGIN
    PRINT(N'THÊM NHÂN VIÊN THÀNH CÔNG')
END
INSERT NHANVIEN VALUES (N'NV12',N'TRUNG TRẦN 12345',N'NAM','2002-09-13',N'265, Nguyễn Trãi, Phường Nguyễn Cư Trinh, Quận 1, Thành phố Hồ Chí Minh',N'Khơ-Me',N'074866470',N'GiaHan1309@gmail.com',4500000.0,0);

-- trigger KHÁCH HÀNG
--1. KIỂM TRA SỐ ĐIỆN THOẠI CỦA KHÁCH HÀNG CÓ BỊ TRÙNG HAY KHÔNG
CREATE TRIGGER tg_DIENTHOAI_KHACHHANG ON KHACHHANG
FOR INSERT
AS
BEGIN
    DECLARE @DIENTHOAI NVARCHAR(10)
    SELECT @DIENTHOAI = DIENTHOAI FROM INSERTED 
    IF((SELECT COUNT(*) FROM KHACHHANG WHERE @DIENTHOAI=DIENTHOAI) > 1)
    BEGIN
        RAISERROR (N'SỐ ĐIỆN THOẠI NÀY ĐÃ TỒN TẠI',15,1)
        ROLLBACK TRAN
        RETURN 
    END
END
INSERT KHACHHANG VALUES (N'KH14',N'Dương Phương Quỳnh',N'Nữ',N'2004-08-25',N'196/5, Xóm Chiếu, Phường 14, Quận 4, Thành phố Hồ Chí Minh',N'NAM',N'0858223584',N'phuongquynh2508@gmail.com',5,10100000)

--2. THÊM KHÁCH HÀNG THÀNH CÔNG
CREATE TRIGGER TG_THEMTC_KHACHHANG ON KHACHHANG
FOR INSERT
AS
BEGIN
    PRINT (N'THÊM KHÁCH HÀNG THÀNH CÔNG')
END

--TRIGGER NHÀ CUNG CẤP
--1. KIỂM TRA TÊN NHÀ CUNG CẤP CÓ BỊ TRÙNG HAY KHÔNG
CREATE TRIGGER TG_TEN_NHACUNGCAP ON NHACUNGCAP
FOR INSERT
AS
BEGIN
    DECLARE @TEN NVARCHAR(MAX)
    SELECT @TEN = TENNCC FROM inserted
    IF((SELECT COUNT(*) FROM NHACUNGCAP WHERE @TEN=TENNCC) > 1)
    BEGIN
        RAISERROR (N'TÊN NHÀ CUNG CẤP BỊ TRÙNG',15,1)
        ROLLBACK TRAN
        RETURN 
    END
END
INSERT NHACUNGCAP VALUES (N'NCC13',N'GẤU BÔNG VIPPRO');

--2. THÊM NHÀ CUNG CẤP THÀNH CÔNG
CREATE TRIGGER TG_THEMTC_NHACC ON NHACUNGCAP
FOR INSERT
AS
BEGIN
    PRINT(N'THÊM NHÀ CUNG CẤP THÀNH CÔNG')
END

--TRIGGER HÀNG
--1. KIỂM TRA TÊN HÀNG CÓ BỊ TRÙNG HAY KHÔNG
CREATE TRIGGER TG_TENHANG_HANG ON HANG
FOR INSERT
AS
BEGIN
    DECLARE @TEN NVARCHAR(100)
    SELECT @TEN = TENHANG FROM HANG
    IF((SELECT COUNT(*) FROM HANG WHERE @TEN = TENHANG) > 1)
    BEGIN 
        RAISERROR (N'TÊN HÀNG ĐÃ BỊ TRÙNG',15,1)
        ROLLBACK TRAN
        RETURN 
    END
END
INSERT HANG VALUES (N'MH13',N'GẤU BÔNG TRÁI DÂU',N'V',N'NCC07',N'DB',3350,80000,110000,N'')

--2. KIỂM TRA TÌNH TRẠNG HÀNG (nếu tình trạng hàng là ngừng kinh doanh thì không cho phép thêm vào)
CREATE TRIGGER TG_TINHTRANG1_HANG ON HANG
FOR UPDATE
AS
BEGIN
    DECLARE @MATTSP NVARCHAR(10)
    SELECT @MATTSP = MATTSP FROM INSERTED
    IF(@MATTSP = N'NKD')
    BEGIN
        RAISERROR (N'SẢN PHẨM ĐÃ NGỪNG KINH DOANH KHÔNG THỂ NHẬP HÀNG',15,2)
        ROLLBACK TRAN
        RETURN 
    END
END
UPDATE HANG SET SOLUONG = 2000 WHERE MAHANG = N'MH21';

--3. KIỂM TRA TÌNH TRẠNG HÀNG (NẾU SỐ LƯỢNG BẰNG 0 THÌ TÌNH TRẠNG SẢN PHẨM LÀ HẾT HÀNG)
CREATE TRIGGER YG_TINHTRANG2_HANG ON HANG
FOR UPDATE
AS
BEGIN
    DECLARE @MATTSP NVARCHAR(10), @SOLUONG INT
    SELECT @MATTSP = MATTSP, @SOLUONG = SOLUONG FROM inserted
    IF(@SOLUONG != 0)
    BEGIN
        IF(@MATTSP = N'HH')
        BEGIN
            RAISERROR (N'NẾU NHẬP SỐ LƯỢNG PHẢI ĐỔI LẠI TÌNH TRẠNG SẢN PHẨM',15,2)
            ROLLBACK TRAN
            RETURN
        END
    END
END
UPDATE HANG SET SOLUONG = 0, MATTSP = N'HH' WHERE MAHANG = N'MH17';

--4. KIỂM TRA TÌNH TRẠNG HÀNG (NẾU TÌNH TRẠNG SẢN PHẨM LÀ ĐANG BÁN THÌ SỐ LƯỢNG PHẢI KHÁC 0)
CREATE TRIGGER TG_TINHTRANG3_HANG ON HANG
FOR UPDATE
AS
BEGIN
    DECLARE @MATTSP NVARCHAR(10), @SOLUONG INT
    SELECT @MATTSP = MATTSP, @SOLUONG = SOLUONG FROM inserted
    IF(@MATTSP = N'DB')
    BEGIN
        IF(@SOLUONG = 0)
        BEGIN
            RAISERROR (N'SẢN PHẨM ĐANG BÁN SỐ LƯỢNG KHÔNG ĐƯỢC BẰNG 0',15,2)
            ROLLBACK TRAN
            RETURN 
        END
    END
END
UPDATE HANG SET MATTSP = N'DB', SOLUONG =1500 WHERE MAHANG = N'MH01';

--5. KIỂM TRA TÌNH TRẠNG HÀNG (NẾU SỐ LƯỢNG HÀNG NHẬP VÀO LỚN HƠN 100 THÌ TÌNH TRẠNG SẢN PHẨM PHẢI ĐỔI TỪ CNH SANG DB)
CREATE TRIGGER TG_TINHTRANG4_HANG ON HANG
FOR UPDATE
AS
BEGIN
    DECLARE @SOLUONG INT, @MATTSP NVARCHAR(10)
    SELECT @SOLUONG = SOLUONG, @MATTSP = MATTSP FROM inserted
    IF(@SOLUONG > 100)
    BEGIN
        IF(@MATTSP = N'CNH')
        BEGIN
            RAISERROR (N'VỚI SỐ LƯỢNG SẢN PHẨM NHẬP VÀO BẠN PHẢI ĐỔI TÌNH TRẠNG SẢN PHẨM',15,2)
            ROLLBACK TRAN
            RETURN 
        END
    END
END
UPDATE HANG SET SOLUONG =6, MATTSP = N'CNH' WHERE MAHANG = N'MH16';

--6. THÊM HÀNG THÀNH CÔNG
CREATE TRIGGER TG_THEMTC_HANG ON HAVING
FOR INSERT
AS 
BEGIN
    PRINT(N'THÊM HÀNG THÀNH CÔNG')
END
--TRIGGER CHẤT LIỆU
--1. KHÔNG ĐỂ CHO TÊN CHẤT LIỆU GIỐNG NHAU
CREATE TRIGGER TG_TENCL_CHATLIEU ON CHATLIEU
FOR INSERT
AS
BEGIN
    DECLARE @TEN NVARCHAR(MAX)
    SELECT @TEN = TENCL FROM inserted
    IF((SELECT COUNT(*) FROM CHATLIEU WHERE @TEN=TENCL)>1)
    BEGIN
        RAISERROR (N'TÊN CHẤT LIỆU BỊ TRÙNG',15,1)
        ROLLBACK TRAN
        RETURN
    END
END
INSERT CHATLIEU VALUES (N'VOO',N'Vỏ ốc');

--2. KHI NHẬP CHẤT LIỆU THÀNH CÔNG SẼ XUẤT RA CÂU ""ĐÃ THÊM CHẤT LIỆU THÀNH CÔNG
CREATE TRIGGER TG_THEMTC_CHATLIEU ON CHATLIEU
FOR INSERT
AS
BEGIN
    PRINT N'ĐÃ THÊM CHẤT LIỆU THÀNH CÔNG'
END
INSERT CHATLIEU VALUES (N'PP',N'PHÓT PHO');

--TRIGGER HTTT
--1. KIỂM TRA HÌNH THỨC THANH TOÁN CÓ BỊ TRÙNG HAY KHÔNG
CREATE TRIGGER TG_TENTT_HTTT ON HTTT
FOR INSERT
AS
BEGIN
    DECLARE @TEN NVARCHAR(MAX)
    SELECT @TEN = TENTT FROM inserted
    IF((SELECT COUNT(*) FROM HTTT WHERE @TEN=TENTT)>1)
    BEGIN
        RAISERROR (N'TÊN THANH TOÁN BỊ TRÙNG',15,1)
        ROLLBACK TRAN
        RETURN
    END
END
INSERT HTTT VALUES (N'HTTT',N'THẺ GHI NỢ');

--TRIGGER HTGD
--1. KIỂM TRA TÊN GIAO DỊCH CÓ BỊ TRÙNG HAY KHÔNG
CREATE TRIGGER TG_TENGD_HTGD ON HTGD 
FOR INSERT
AS
BEGIN
    DECLARE @TEN NVARCHAR(MAX)
    SELECT @TEN = TENGD FROM INSERTED 
    IF((SELECT COUNT(*) FROM HTGD WHERE @TEN=TENGD)>1)
    BEGIN
        RAISERROR (N'TÊN GIAO DỊCH BỊ TRÙNG',15,1)
        ROLLBACK TRAN
        RETURN
    END
END
INSERT HTGD VALUES (N'HTGD',N'WEB THƯƠNG MẠI');

--2. THÊM HÌNH THỨC GIAO DỊCH
CREATE TRIGGER TG_THEMTC_HTGD ON HTGD
FOR INSERT
AS
BEGIN
    PRINT(N'THÊM HÌNH THỨC GIAO DỊCH THÀNH CÔNG')
END

--TRIGGER LICHSUDONGIA
--1. GIÁ NHẬP PHẢI THẤP HƠN GIÁ BÁN
CREATE TRIGGER TG_GIA_LICHSUDONGIA ON LICHSUDONGIA
FOR INSERT
AS
BEGIN
    DECLARE @NHAP FLOAT, @BAN FLOAT
    SELECT @NHAP = DONGIANHAPMOI, @BAN = DONGIABANMOI FROM inserted
    IF(@NHAP - @BAN > 0)
    BEGIN
        RAISERROR (N'GIÁ BÁN PHẢI LỚN HƠN GIÁ NHẬP',15,1)
        ROLLBACK TRAN
        RETURN
    END
END
INSERT LICHSUDONGIA VALUES (N'MALS17',N'MH12',80000,120000,100000,110000,'2020-07-15');