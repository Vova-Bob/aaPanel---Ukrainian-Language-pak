#!/bin/bash

# Визначаємо URL для скачування
REPO_URL="https://github.com/Vova-Bob/aaPanel---Ukrainian-Language-pak/archive/refs/heads/main.zip"
LANGUAGE_PACK="BTPanel"
INSTALL_DIR="/www/server/panel/$LANGUAGE_PACK"

# Перевірка наявності прав на запис у директорію
if [ ! -w "/www/server/panel/" ]; then
    echo "Помилка: у вас немає прав на запис до директорії /www/server/panel/. Використайте sudo для запуску скрипта."
    exit 1
fi

# Функція для завантаження файлів
download_file() {
    if command -v curl &> /dev/null; then
        curl -L -o "$1" "$2"
    elif command -v wget &> /dev/null; then
        wget -q -O "$1" "$2"
    else
        echo "Помилка: не знайдено 'curl' або 'wget'."
        exit 1
    fi
}

# Завантажуємо файли з репозиторію
echo "Завантаження мовного пакету з GitHub..."
download_file "temp_repo.zip" "$REPO_URL"

# Розпаковуємо ZIP-файл
unzip -q temp_repo.zip
mv "aaPanel---Ukrainian-Language-pak-main/$LANGUAGE_PACK" temp_repo
rm temp_repo.zip

# Копіюємо файли до директорії aapanel
echo "Копіювання мовного пакету до $INSTALL_DIR..."
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR/*"
else
    mkdir -p "$INSTALL_DIR"
fi

# Копіюємо лише потрібні файли, виключаючи непотрібні
shopt -s extglob
cp -r temp_repo/!(LICENSE|README.md|ua_language_pack.sh)/* "$INSTALL_DIR/" || {
    echo "Помилка при копіюванні файлів до $INSTALL_DIR."
    exit 1
}

# Очищуємо тимчасову папку
rm -rf temp_repo

echo "Мовний пакет успішно встановлено!"
