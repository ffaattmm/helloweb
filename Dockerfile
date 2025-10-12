
# مرحله 1: ساخت (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# کپی تمام فایل‌های پروژه به داخل کانتینر
COPY . ./

# بازیابی پکیج‌ها و ساخت خروجی release
RUN dotnet restore
RUN dotnet publish -c Release -o out

# مرحله 2: اجرا (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# مشخص کردن پورت داخل کانتینر
EXPOSE 5247

# اجرای برنامه
ENTRYPOINT ["dotnet", "HelloWeb.dll"]
