# ASM News - Website Tin Tức

## Mô tả dự án
Website tin tức được phát triển theo yêu cầu Assignment Java 3 của FPT Polytechnic. Hệ thống hỗ trợ 3 đối tượng người dùng:
- **Độc giả**: Xem tin tức, đăng ký nhận tin qua email
- **Phóng viên**: Quản lý tin tức của mình
- **Quản trị viên**: Quản lý toàn bộ hệ thống

## Công nghệ sử dụng
- **Backend**: Java Servlet/JSP, JDBC
- **Frontend**: Bootstrap 5, Font Awesome, HTML/CSS/JavaScript
- **Database**: SQL Server
- **Build Tool**: Maven
- **Server**: Apache Tomcat 10+

## Cấu trúc dự án
```
asm-news/
├── src/main/java/com/example/asmnews/
│   ├── entity/          # Các entity classes
│   ├── dao/             # Data Access Objects
│   ├── servlet/         # Controllers (Servlets)
│   └── utils/           # Utility classes
├── src/main/webapp/
│   ├── WEB-INF/views/   # JSP views
│   ├── images/          # Hình ảnh tin tức
│   └── web.xml          # Web configuration
├── database.sql         # Script tạo database
└── pom.xml              # Maven configuration
```

## Hướng dẫn cài đặt

### 1. Yêu cầu hệ thống
- Java 11 hoặc cao hơn
- Apache Tomcat 10+
- SQL Server 2019+
- Maven 3.6+

### 2. Cài đặt Database
1. Mở SQL Server Management Studio
2. Chạy script `database.sql` để tạo database và dữ liệu mẫu
3. Cập nhật thông tin kết nối database trong `DatabaseUtils.java`:
   ```java
   private static final String SERVER = "localhost";
   private static final String DATABASE = "ASM_NEWS";
   private static final String USERNAME = "sa";
   private static final String PASSWORD = "123";
   ```

### 3. Build và Deploy
1. Clone project về máy
2. Mở terminal tại thư mục project
3. Chạy lệnh build:
   ```bash
   mvn clean package
   ```
4. Deploy file `target/asm-news-1.0.0.war` lên Tomcat
5. Truy cập: `http://localhost:8080/asm-news`

## Tài khoản demo
- **Admin**: `admin` / `123456`
- **Phóng viên 1**: `reporter1` / `123456`
- **Phóng viên 2**: `reporter2` / `123456`

## Chức năng chính

### Dành cho độc giả (Public)
- ✅ Xem danh sách tin tức
- ✅ Xem chi tiết tin tức
- ✅ Xem tin tức theo chuyên mục
- ✅ Xem tin nổi bật trên trang chủ
- ✅ Xem top tin được xem nhiều nhất
- ✅ Xem tin mới nhất
- ✅ Đăng ký nhận tin qua email
- ✅ Hủy đăng ký nhận tin

### Dành cho phóng viên
- ✅ Đăng nhập/đăng xuất
- ✅ Xem dashboard cá nhân
- ✅ Thêm tin tức mới
- ✅ Sửa tin tức của mình
- ✅ Xóa tin tức của mình
- ✅ Xem danh sách tin tức đã viết

### Dành cho quản trị viên
- ✅ Tất cả chức năng của phóng viên
- ✅ Quản lý tất cả tin tức (CRUD)
- ✅ Quản lý chuyên mục (CRUD)
- ✅ Quản lý người dùng (CRUD)
- ✅ Quản lý đăng ký newsletter (CRUD)
- ✅ Xem thống kê tổng quan
- ✅ Thiết lập tin hiển thị trang chủ

## Cấu trúc Database

### Bảng Categories
- `Id` (NVARCHAR(50), PK): Mã loại tin
- `Name` (NVARCHAR(255)): Tên loại tin

### Bảng Users
- `Id` (NVARCHAR(50), PK): Mã người dùng
- `Password` (NVARCHAR(255)): Mật khẩu
- `Fullname` (NVARCHAR(255)): Họ tên
- `Birthday` (DATE): Ngày sinh
- `Gender` (BIT): Giới tính (1: Nam, 0: Nữ)
- `Mobile` (NVARCHAR(20)): Số điện thoại
- `Email` (NVARCHAR(255)): Email
- `Role` (BIT): Vai trò (1: Admin, 0: Phóng viên)

### Bảng News
- `Id` (NVARCHAR(50), PK): Mã tin tức
- `Title` (NVARCHAR(500)): Tiêu đề
- `Content` (NTEXT): Nội dung
- `Image` (NVARCHAR(255)): Hình ảnh
- `PostedDate` (DATE): Ngày đăng
- `Author` (NVARCHAR(50), FK): Tác giả
- `ViewCount` (INT): Lượt xem
- `CategoryId` (NVARCHAR(50), FK): Loại tin
- `Home` (BIT): Hiển thị trang chủ

### Bảng Newsletters
- `Email` (NVARCHAR(255), PK): Email đăng ký
- `Enabled` (BIT): Trạng thái (1: Hoạt động, 0: Hủy)

## Giao diện

### Trang công khai
- Thiết kế responsive với Bootstrap 5
- Header với menu điều hướng
- Sidebar hiển thị tin nổi bật, chuyên mục
- Footer với form đăng ký newsletter
- Hiệu ứng hover và animation

### Trang quản trị
- Dashboard với thống kê tổng quan
- Sidebar menu cho các chức năng
- Bảng dữ liệu với phân trang
- Form thêm/sửa với validation
- Thông báo success/error

## Tính năng nổi bật
- ✅ Phân quyền rõ ràng (Admin/Reporter)
- ✅ Giao diện đẹp, responsive
- ✅ Validation dữ liệu đầu vào
- ✅ Xử lý lỗi và thông báo
- ✅ Upload và quản lý hình ảnh
- ✅ Tìm kiếm và lọc dữ liệu
- ✅ Thống kê và báo cáo
- ✅ Newsletter system

## Hướng dẫn sử dụng

### 1. Truy cập trang chủ
- Vào `http://localhost:8080/asm-news`
- Xem tin tức, đăng ký newsletter

### 2. Đăng nhập quản trị
- Click "Đăng nhập" trên header
- Sử dụng tài khoản demo để đăng nhập
- Truy cập các chức năng quản trị

### 3. Quản lý tin tức
- Thêm tin tức: Điền form và submit
- Sửa tin tức: Click icon edit
- Xóa tin tức: Click icon delete
- Thiết lập hiển thị trang chủ: Check "Home"

### 4. Thêm ảnh cho tin tức

#### Cách 1: Upload qua website (Khuyến nghị)
1. Đăng nhập admin/phóng viên
2. Vào "Quản lý tin tức" → "Thêm tin tức mới"
3. Trong phần "Hình ảnh":
   - Kéo thả ảnh vào vùng upload
   - Hoặc click để chọn file
   - Hỗ trợ: JPG, PNG, GIF (tối đa 10MB)
4. Điền thông tin tin tức và lưu

#### Cách 2: Thêm ảnh có sẵn
1. Copy ảnh vào thư mục `src/main/webapp/images/`
2. Đặt tên đơn giản: `sport1.jpg`, `tech1.png`
3. Khi thêm tin tức, nhập tên file vào trường "Hình ảnh"

### 5. Quản lý hệ thống (Admin)
- Quản lý chuyên mục: Thêm/sửa/xóa categories
- Quản lý người dùng: Tạo tài khoản phóng viên
- Quản lý newsletter: Xem danh sách đăng ký

## Lưu ý kỹ thuật
- Sử dụng Connection Pool để tối ưu database
- Implement DAO pattern cho data access
- Sử dụng PreparedStatement để tránh SQL Injection
- Session management cho authentication
- Error handling và logging
- Responsive design cho mobile

## Tác giả
Sinh viên FPT Polytechnic - Assignment Java 3

## Phiên bản
Version 1.0.0 - Tháng 10/2024
