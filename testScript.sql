USE master
GO
CREATE DATABASE ASSPRJ
GO

USE [ASSPRJ]
GO
/****** Object:  Table [dbo].[HouseholdMembers]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HouseholdMembers](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[HouseholdID] [int] NULL,
	[UserID] [int] NULL,
	[Relationship] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Households]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Households](
	[HouseholdID] [int] IDENTITY(1,1) NOT NULL,
	[HouseholdCode] [nvarchar](50) NULL,
	[HeadOfHouseholdID] [int] NULL,
	[ProvinceID] [int] NOT NULL,
	[DistrictID] [int] NOT NULL,
	[WardID] [int] NOT NULL,
	[AddressDetail] [nvarchar](100) NULL,
	[CreatedDate] [date] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[HouseholdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[HouseholdCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Timestamp] [datetime] NULL,
	[HouseholdID] [int] NULL,
	[RegistrationType] [varchar](50) NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Message] [nvarchar](max) NOT NULL,
	[SentDate] [datetime] NULL,
	[IsRead] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationImages]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationImages](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationID] [int] NOT NULL,
	[ImageURL] [nvarchar](500) NOT NULL,
	[ImageType] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registrations]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registrations](
	[RegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationCode] [nvarchar](25) NULL,
	[UserID] [int] NULL,
	[RegistrationType] [nvarchar](50) NOT NULL,
	[HouseholdID] [int] NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[Status] [nvarchar](50) NULL,
	[ApprovedBy] [int] NULL,
	[Comments] [nvarchar](max) NULL,
	[Relationship] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RegistrationCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[CCCD] [nvarchar](14) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](12) NULL,
	[Password] [nvarchar](255) NULL,
	[Role] [nvarchar](50) NOT NULL,
	[ProvinceID] [int] NOT NULL,
	[DistrictID] [int] NOT NULL,
	[WardID] [int] NOT NULL,
	[AddressDetail] [nvarchar](100) NULL,
	[Status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CCCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Households] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Households] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Logs] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [SentDate]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Registrations] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('pending') FOR [Status]
GO
ALTER TABLE [dbo].[HouseholdMembers]  WITH CHECK ADD FOREIGN KEY([HouseholdID])
REFERENCES [dbo].[Households] ([HouseholdID])
GO
ALTER TABLE [dbo].[HouseholdMembers]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Households]  WITH CHECK ADD FOREIGN KEY([HeadOfHouseholdID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RegistrationImages]  WITH CHECK ADD FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[Registrations] ([RegistrationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD FOREIGN KEY([ApprovedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD FOREIGN KEY([HouseholdID])
REFERENCES [dbo].[Households] ([HouseholdID])
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD CHECK  (([RegistrationType]='TemporaryStay' OR [RegistrationType]='Temporary' OR [RegistrationType]='Permanent'))
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD  CONSTRAINT [CK_Registrations_Status] CHECK  (([Status]='Rejected' OR [Status]='Approved' OR [Status]='PreApproved' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[Registrations] CHECK CONSTRAINT [CK_Registrations_Status]
GO
/****** Object:  StoredProcedure [dbo].[ApprovePermanentRegistration]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ApprovePermanentRegistration]
    @RegistrationID INT,
    @Relationship NVARCHAR(50)  -- Quan hệ với chủ hộ
AS
BEGIN
    DECLARE @UserID INT, @NewHouseholdID INT, @RegistrationType NVARCHAR(50);
    DECLARE @ProvinceID INT, @DistrictID INT, @WardID INT, @AddressDetail NVARCHAR(255);
    DECLARE @HouseholdCode NVARCHAR(50), @HouseholdCount INT;
    DECLARE @OldHouseholdID INT, @StartDate DATE, @Status NVARCHAR(20);

    -- Lấy thông tin từ đơn đăng ký
    SELECT @UserID = UserID, 
           @NewHouseholdID = HouseholdID, 
           @RegistrationType = RegistrationType,
           @StartDate = StartDate,
           @Status = Status
    FROM Registrations
    WHERE RegistrationID = @RegistrationID AND RegistrationType = 'Permanent';

    -- Kiểm tra nếu đơn có tồn tại
    IF @UserID IS NOT NULL
    BEGIN
        -- Kiểm tra hộ khẩu cũ của người này
        SELECT @OldHouseholdID = HouseholdID
        FROM HouseholdMembers
        WHERE UserID = @UserID;

        -- Trường hợp tạo hộ khẩu mới
        IF @NewHouseholdID IS NULL
        BEGIN
            IF @Status = 'Rejected'
            BEGIN
                -- Xóa hộ khẩu nếu bị từ chối
                DELETE FROM Households 
				WHERE HouseholdCode LIKE '%_' + CAST(@RegistrationID AS NVARCHAR)
            END
            ELSE IF @Status = 'Approved'
            BEGIN
                UPDATE Households
				SET Status = 1
				WHERE HouseholdCode LIKE '%_' + CAST(@RegistrationID AS NVARCHAR);
				SELECT @NewHouseholdID = HouseholdID
				FROM Households
				WHERE HouseholdCode LIKE '%_' + CAST(@RegistrationID AS NVARCHAR);
            END;
        END;

        -- Nếu đơn được duyệt, thêm vào hộ khẩu mới
        IF @Status = 'Approved'
        BEGIN
            -- Kiểm tra nếu người này đã có hộ khẩu cũ thì cập nhật EndDate trong Logs và xóa khỏi HouseholdMembers
            IF @OldHouseholdID IS NOT NULL AND @OldHouseholdID <> @NewHouseholdID
            BEGIN
                UPDATE Logs 
                SET EndDate = GETDATE()
                WHERE UserID = @UserID AND HouseholdID = @OldHouseholdID 
                      AND RegistrationType = 'Permanent' AND EndDate IS NULL;

                -- Xóa người khỏi hộ khẩu cũ
                DELETE FROM HouseholdMembers WHERE UserID = @UserID AND HouseholdID = @OldHouseholdID;
            END;

            -- Thêm người vào hộ khẩu mới
            INSERT INTO HouseholdMembers (HouseholdID, UserID, Relationship)
            VALUES (@NewHouseholdID, @UserID, @Relationship);

            -- Ghi log đăng ký thường trú
            INSERT INTO Logs (UserID, Timestamp, HouseholdID, RegistrationType, StartDate, EndDate)
            VALUES (@UserID, GETDATE(), @NewHouseholdID, 'Permanent', @StartDate, NULL);
        END;
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[ApproveTemporaryRegistration]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ApproveTemporaryRegistration]
    @RegistrationID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserID INT, @HouseholdID INT, @CurrentDate DATE, @StartDate DATE, @EndDate DATE, @Status NVARCHAR(20);

    SET @CurrentDate = GETDATE();

    -- Lấy thông tin từ đơn đăng ký
    SELECT @UserID = UserID, @HouseholdID = HouseholdID, @StartDate = StartDate, @EndDate = EndDate, @Status = Status
    FROM Registrations
    WHERE RegistrationID = @RegistrationID;

    -- Nếu trạng thái không phải 'Approved', thoát procedure
    IF @Status <> 'Approved'
        RETURN;

    -- Kiểm tra nếu người dùng đang có tạm trú ở hộ khẩu khác
    IF EXISTS (
        SELECT 1 
        FROM Logs 
        WHERE UserID = @UserID 
            AND RegistrationType = 'Temporary' 
            AND EndDate > @CurrentDate
    )
    BEGIN
        -- Cập nhật EndDate của tạm trú cũ về ngày hôm nay
        UPDATE Logs
        SET EndDate = @CurrentDate
        WHERE UserID = @UserID 
            AND RegistrationType = 'Temporary' 
            AND EndDate > @CurrentDate;
    END

    -- Thêm mới vào Logs việc tạm trú tại hộ khẩu mới với StartDate và EndDate từ Registration
    INSERT INTO Logs (UserID, Timestamp, HouseholdID, RegistrationType, StartDate, EndDate)
    VALUES (@UserID, @CurrentDate, @HouseholdID, 'Temporary', @StartDate, @EndDate);
END;
GO
/****** Object:  StoredProcedure [dbo].[ApproveTemporaryStayRegistration]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ApproveTemporaryStayRegistration]
    @RegistrationID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserID INT, @HouseholdID INT, @StartDate DATE, @EndDate DATE, @Status NVARCHAR(20);

    -- Lấy thông tin từ bảng Registrations
    SELECT @UserID = UserID, 
           @HouseholdID = HouseholdID, 
           @StartDate = StartDate, 
           @EndDate = EndDate, 
           @Status = Status
    FROM Registrations
    WHERE RegistrationID = @RegistrationID;

    -- Chỉ xử lý nếu Status là 'Approved'
    IF @Status = 'Approved'
    BEGIN
        -- Ghi log vào bảng Logs
        INSERT INTO Logs (UserID, Timestamp, HouseholdID, RegistrationType, StartDate, EndDate)
        VALUES (@UserID, GETDATE(), @HouseholdID, 'TemporaryStay', @StartDate, @EndDate);
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteUser]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Xóa dữ liệu liên quan trước khi xóa User
    DELETE FROM HouseholdMembers WHERE UserID = @UserID;
    DELETE FROM Households WHERE HeadOfHouseholdID = @UserID;
    DELETE FROM Logs WHERE UserID = @UserID;
    DELETE FROM Notifications WHERE UserID = @UserID;
    DELETE FROM Registrations WHERE UserID = @UserID OR ApprovedBy = @UserID;
    
    -- Cuối cùng xóa User
    DELETE FROM Users WHERE UserID = @UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserInfo]    Script Date: 3/23/2025 8:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateUserInfo]
    @UserID INT,
    @FullName NVARCHAR(100),
    @DateOfBirth DATE,
    @CCCD NVARCHAR(14),
    @Email NVARCHAR(100),
    @PhoneNumber NVARCHAR(12),
    @Password NVARCHAR(255),
    @Role NVARCHAR(50),
    @ProvinceID INT,
    @DistrictID INT,
    @WardID INT,
    @AddressDetail NVARCHAR(100),
    @Status VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Kiểm tra xem UserID có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        RAISERROR('UserID không tồn tại.', 16, 1);
        RETURN;
    END
    
    -- Kiểm tra trùng CCCD
    IF EXISTS (SELECT 1 FROM Users WHERE CCCD = @CCCD AND UserID <> @UserID)
    BEGIN
        RAISERROR('CCCD đã tồn tại.', 16, 1);
        RETURN;
    END
    
    -- Kiểm tra trùng Email
    IF EXISTS (SELECT 1 FROM Users WHERE Email = @Email AND UserID <> @UserID)
    BEGIN
        RAISERROR('Email đã tồn tại.', 16, 1);
        RETURN;
    END
    
    -- Kiểm tra trùng PhoneNumber
    IF EXISTS (SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber AND UserID <> @UserID)
    BEGIN
        RAISERROR('Số điện thoại đã tồn tại.', 16, 1);
        RETURN;
    END
    
    -- Cập nhật thông tin người dùng
    UPDATE Users
    SET FullName = @FullName,
        DateOfBirth = @DateOfBirth,
        CCCD = @CCCD,
        Email = @Email,
        PhoneNumber = @PhoneNumber,
        Password = @Password,
        Role = @Role,
        ProvinceID = @ProvinceID,
        DistrictID = @DistrictID,
        WardID = @WardID,
        AddressDetail = @AddressDetail,
        Status = @Status
    WHERE UserID = @UserID;
    
    PRINT 'Cập nhật thông tin thành công.';
END;
GO

CREATE TRIGGER trg_AutoApproveRegistration
ON Registrations
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RegistrationID INT, @RegistrationType NVARCHAR(50), @Status NVARCHAR(20), @Relationship NVARCHAR(50);

    -- Lặp qua tất cả các đơn đăng ký được cập nhật
    DECLARE cur CURSOR FOR
    SELECT RegistrationID, RegistrationType, Status, Relationship
    FROM INSERTED;

    OPEN cur;
    FETCH NEXT FROM cur INTO @RegistrationID, @RegistrationType, @Status, @Relationship;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Nếu là đăng ký thường trú, truyền thêm @Relationship
        IF @RegistrationType = 'Permanent'
        BEGIN
            EXEC ApprovePermanentRegistration @RegistrationID, @Relationship;
        END
        -- Nếu là đăng ký tạm trú
        ELSE IF @RegistrationType = 'Temporary'
        BEGIN
            EXEC ApproveTemporaryRegistration @RegistrationID;
        END
		ELSE IF @RegistrationType = 'TemporaryStay'
        BEGIN
            EXEC ApproveTemporaryStayRegistration @RegistrationID;
        END

        FETCH NEXT FROM cur INTO @RegistrationID, @RegistrationType, @Status, @Relationship;
    END

    CLOSE cur;
    DEALLOCATE cur;
END;
GO

CREATE TRIGGER trg_AutoGenerateRegistrationCode
ON Registrations
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Today VARCHAR(6) = CONVERT(VARCHAR(6), GETDATE(), 12); -- YYMMDD
    DECLARE @UserID INT, @NextNumber INT, @RegistrationCode NVARCHAR(20);

    -- Duyệt từng bản ghi trong inserted
    DECLARE cur CURSOR FOR
    SELECT UserID FROM inserted;

    OPEN cur;
    FETCH NEXT FROM cur INTO @UserID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRANSACTION;

        -- Lấy số thứ tự lớn nhất của User trong ngày và +1
        SELECT @NextNumber = ISNULL(MAX(CAST(RIGHT(RegistrationCode, 2) AS INT)), 0) + 1
        FROM Registrations WITH (TABLOCKX) -- Khóa bảng tạm thời
        WHERE UserID = @UserID AND CONVERT(VARCHAR(6), StartDate, 12) = @Today;

        -- Tạo mã đăng ký
        SET @RegistrationCode = CONCAT('re_', @Today, '_', @UserID, '_', FORMAT(@NextNumber, '00'));

        -- Kiểm tra nếu trùng thì tăng số
        WHILE EXISTS (SELECT 1 FROM Registrations WHERE RegistrationCode = @RegistrationCode)
        BEGIN
            SET @NextNumber = @NextNumber + 1;
            SET @RegistrationCode = CONCAT('re_', @Today, '_', @UserID, '_', FORMAT(@NextNumber, '00'));
        END

        -- Thêm vào bảng Registrations
        INSERT INTO Registrations (RegistrationCode, UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship)
        SELECT @RegistrationCode, UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship
        FROM inserted
        WHERE UserID = @UserID;

        COMMIT TRANSACTION;

        FETCH NEXT FROM cur INTO @UserID;
    END

    CLOSE cur;
    DEALLOCATE cur;
END;
GO

CREATE TRIGGER GenerateHouseholdCode
ON Households
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @HouseholdID INT, @ProvinceID INT, @DistrictID INT, @WardID INT, @HouseholdCount INT, @HeadOfHouseholdID INT;
    DECLARE @HouseholdCode NVARCHAR(50);

    -- Lấy thông tin từ bản ghi vừa được INSERT
    SELECT @HouseholdID = HouseholdID, 
           @ProvinceID = ProvinceID, 
           @DistrictID = DistrictID, 
           @WardID = WardID,
		   @HeadOfHouseholdID = HeadOfHouseholdID
    FROM inserted;

	SELECT TOP 1 @HouseholdCount = RegistrationID
	FROM Registrations
	WHERE UserID = @HeadOfHouseholdID
	ORDER BY RegistrationID DESC;
    -- Tạo HouseholdCode
    SET @HouseholdCode = 'hh_' + CAST(@ProvinceID AS NVARCHAR) + '_' + 
                         CAST(@DistrictID AS NVARCHAR) + '_' + 
                         CAST(@WardID AS NVARCHAR) + '_' + 
                         CAST(@HouseholdCount AS NVARCHAR);

    -- Cập nhật HouseholdCode cho bản ghi vừa thêm vào
    UPDATE Households
    SET HouseholdCode = @HouseholdCode
    WHERE HouseholdID = @HouseholdID;
END;
GO

CREATE TRIGGER trg_Update_Household_Status
ON Households
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Chỉ thực hiện khi status chuyển từ 1 -> 0
    IF UPDATE(Status)
    BEGIN
        -- Xóa tất cả thành viên trong HouseholdMembers khi household bị vô hiệu hóa
        DELETE HM 
        FROM HouseholdMembers HM
        INNER JOIN inserted i ON HM.HouseholdID = i.HouseholdID
        INNER JOIN deleted d ON i.HouseholdID = d.HouseholdID
        WHERE d.Status = 1 AND i.Status = 0;

        -- Cập nhật EndDate trong Logs khi Household bị vô hiệu hóa
        UPDATE Logs
        SET EndDate = GETDATE()
        FROM Logs L
        INNER JOIN inserted i ON L.HouseholdID = i.HouseholdID
        INNER JOIN deleted d ON i.HouseholdID = d.HouseholdID
        WHERE d.Status = 1 AND i.Status = 0
        AND L.UserID = i.HeadOfHouseholdID
        AND L.EndDate IS NULL; -- Chỉ cập nhật nếu EndDate chưa có giá trị
		
		DELETE H
        FROM Households H
        INNER JOIN inserted i ON H.HouseholdID = i.HouseholdID
        INNER JOIN deleted d ON i.HouseholdID = d.HouseholdID
        WHERE d.Status = 1 AND i.Status = 0;
    END
END;
GO

CREATE TRIGGER trg_DeleteRejectedUser
ON Users
AFTER UPDATE
AS
BEGIN
    -- Xóa user nếu Status bị cập nhật thành 'rejected'
    DELETE FROM Users
    WHERE UserID IN (
        SELECT inserted.UserID
        FROM inserted
        JOIN deleted ON inserted.UserID = deleted.UserID
        WHERE inserted.Status = 'rejected'
    );
END;

GO

INSERT INTO Users (FullName, DateOfBirth, CCCD, Email, PhoneNumber, Password, Role, ProvinceID, DistrictID, WardID, AddressDetail, Status)  
VALUES  
(N'Nguyễn Văn A', '1990-05-15', '123456789012', 'nguyenvana1@example.com', '0987654321', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Đông, Xã A', 'approved'),  
(N'Trần Thị B', '1985-08-20', '123456789013', 'tranthib2@example.com', '0987654322', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Tây, Xã A', 'approved'),  
(N'Lê Văn C', '1992-12-10', '123456789014', 'levanc3@example.com', '0987654323', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Bắc, Xã A',  'approved'),  
(N'Phạm Thị D', '1988-07-05', '123456789015', 'phamthid4@example.com', '0987654324', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Nam, Xã A', 'approved'),  
(N'Hoàng Văn E', '1995-03-25', '123456789016', 'hoangvane5@example.com', '0987654325', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 1, Xã A', 'approved'),  
(N'Bùi Thị F', '1991-09-15', '123456789017', 'buithif6@example.com', '0987654326', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 2, Xã A', 'approved'),  
(N'Đặng Văn G', '1983-06-18', '123456789018', 'dangvang7@example.com', '0987654327', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 3, Xã A', 'approved'),  
(N'Ngô Thị H', '1997-04-08', '123456789019', 'ngothih8@example.com', '0987654328', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 4, Xã A', 'approved'),  
(N'Vũ Văn I', '1994-11-30', '123456789020', 'vuvani9@example.com', '0987654329', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Trung, Xã A', 'approved'),  
(N'Đỗ Thị J', '1989-02-21', '123456789021', 'dothij10@example.com', '0987654330', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Hạ, Xã A', 'approved'),  
(N'Tô Văn K', '1996-10-14', '123456789022', 'tovank11@example.com', '0987654331', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Cao, Xã A', 'approved'),  
(N'Lý Thị L', '1993-05-09', '123456789023', 'lythil12@example.com', '0987654332', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 5, Xã A', 'approved'),  
(N'Hồ Văn M', '1987-07-22', '123456789024', 'hovanm13@example.com', '0987654333', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 6, Xã A', 'approved'),  
(N'Cao Thị N', '1998-01-31', '123456789025', 'caothin14@example.com', '0987654334', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 7, Xã A', 'approved'),  
(N'Hà Văn O', '1990-09-17', '123456789026', 'havano15@example.com', '0987654335', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 8, Xã A', 'approved'),  
(N'Phùng Thị P', '1995-12-06', '123456789027', 'phungthip16@example.com', '0987654336', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Giữa, Xã A', 'approved'),  
(N'Tổ Trưởng Khu 6', '1991-03-11', 'totruongkhu6', null, null, '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'AreaLeader', 1, 1, 1, N'Khu 6', 'approved'),  
(N'Tổ Trưởng Khu 5', '1986-08-23', 'totruongkhu5', null, null, '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'AreaLeader', 1, 1, 1, N'Khu 5', 'approved'),  
(N'Công an Quận 1', '1997-06-15', 'conganphucxa', null, null, '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Police', 1, 1, 1, null, 'approved'),  
(N'admin', '1111-11-11', 'admin', null, null, '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Admin', 1, 1, 1, null, 'approved');

GO
INSERT INTO Users (FullName, DateOfBirth, CCCD, Email, PhoneNumber, Password, Role, ProvinceID, DistrictID, WardID, AddressDetail, Status)  
VALUES  
(N'Nguyễn Văn A', '1990-05-15', '123456789313', 'nguyenvan2a1@example.com', '0987654221', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Đông, Xã A',  'pending'),  
(N'Trần Thị B', '1985-08-20', '123456784014', 'tranthi2b2@example.com', '0987634322', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Tây, Xã A',  'pending'),  
(N'Lê Văn C', '1992-12-10', '123456289014', 'levan2c3@example.com', '0987654523', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Bắc, Xã A',  'pending'),  
(N'Phạm Thị D', '1988-07-05', '123236789015', 'pham2thid4@example.com', '0912654324', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Thôn Nam, Xã A',  'pending'),  
(N'Hoàng Văn E', '1995-03-25', '124456789016', 'hoan2gvane5@example.com', '0937654325', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 1, Xã A',  'pending'),  
(N'Bùi Thị F', '1991-09-15', '123456756017', 'buithi2f6@example.com', '0987432326', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 2, Xã A',  'pending'),  
(N'Đặng Văn G', '1983-06-18', '123534789018', 'dangv2ang7@example.com', '0981234327', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 3, Xã A',  'pending'),  
(N'Ngô Thị H', '1997-04-08', '123452389019', 'ngot2hih8@example.com', '0983254328', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', 'Citizen', 1, 1, 1, N'Xóm 4, Xã A',  'pending');
GO
INSERT INTO Registrations 
(UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship)  
VALUES  
(1, 'Permanent', null, '2024-01-10', NULL, 'Pending', 17, 'Nhanh cho tôi', N'Chủ hộ'),  
(2, 'Permanent', null, '2024-02-15', NULL, 'Pending', 18, 'Đã gửi đủ thông tin', N'Chủ hộ');
GO
INSERT INTO Households
(HeadOfHouseholdID,ProvinceID,DistrictID,WardID,AddressDetail,CreatedDate)
VALUES
(1,1,1,1,N'Thôn 3','2024-01-10');
GO
INSERT INTO Households
(HeadOfHouseholdID,ProvinceID,DistrictID,WardID,AddressDetail,CreatedDate)
VALUES
(2,1,1,1,N'Thôn 2', '2024-02-15');
GO
UPDATE Registrations
SET Status = 'Approved'
WHERE RegistrationID < 5
GO
INSERT INTO Registrations 
(UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship)  
VALUES  
(3, 'Temporary', 1, '2024-01-10', '2025-03-30', 'Pending', 17, N'Tôi cần gấp', N'Thuê trọ'),  
(4, 'Temporary', 2, '2024-02-15', '2025-03-30', 'Pending', 18, N'Đã gửi đủ thông tin', N'Thuê nhà');
GO
UPDATE Registrations
SET Status = 'Approved'
WHERE RegistrationID = 3;
GO
UPDATE Registrations
SET Status = 'Approved'
WHERE RegistrationID = 4;
GO
INSERT INTO Registrations 
(UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship)  
VALUES  
(5, 'Temporary', 1, '2024-01-10', '2025-03-30', 'Pending', 17, N'Tôi cần gấp', N'Thuê trọ'),  
(6, 'Temporary', 2, '2024-02-15', '2025-03-30', 'Pending', 18, N'Đã gửi đủ thông tin', N'Thuê nhà');
GO
INSERT INTO Registrations 
(UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship)  
VALUES  
(7, 'Permanent', 1, '2024-01-10', null, 'Pending', 17, N'Tôi cần gấp', N'Con trai'),  
(8, 'Permanent', 2, '2024-02-15', null, 'Pending', 18, N'Đã gửi đủ thông tin', N'Vợ');
GO
UPDATE Registrations
SET Status = 'Approved'
WHERE RegistrationID = 7;
GO
UPDATE Registrations
SET Status = 'Approved'
WHERE RegistrationID = 8;
GO

INSERT INTO Registrations 
(UserID, RegistrationType, HouseholdID, StartDate, EndDate, Status, ApprovedBy, Comments, Relationship)  
VALUES  
(9, 'Temporary', 1, '2024-01-10', '2025-03-30', 'PreApproved', 17, N'Tôi cần gấp', N'Thuê trọ'),  
(10, 'Temporary', 2, '2024-02-15', '2025-03-30', 'PreApproved', 18, N'Đã gửi đủ thông tin', N'Thuê nhà');
GO