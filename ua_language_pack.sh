#!/bin/bash

# Визначаємо URL для скачування
REPO_URL="https://github.com/Vova-Bob/aaPanel---Ukrainian-Language-pak"
LANGUAGE_PACK="BTPanel"

# Директорія для установки
INSTALL_DIR="/www/server/panel/$LANGUAGE_PACK"

# Завантажуємо файли з репозиторію
echo "Завантаження мовного пакету з GitHub..."
if command -v git &> /dev/null; then
    # Якщо git доступний, клонуємо репозиторій
    git clone --depth=1 "$REPO_URL" temp_repo
else
    echo "git не знайдено, спробуємо використати wget для завантаження."
    wget -q -O temp_repo.zip "$REPO_URL/archive/refs/heads/main.zip"
    unzip -q temp_repo.zip
    mv "aaPanel---Ukrainian-Language-pak-main/$LANGUAGE_PACK" temp_repo
    rm -rf aaPanel---Ukrainian-Language-pak-main temp_repo.zip
fi

# Копіюємо файли до директорії aapanel
echo "Копіювання мовного пакету до $INSTALL_DIR..."
if [ -d "$INSTALL_DIR" ]; then
    # Заміна файлів у разі наявності
    rm -rf "$INSTALL_DIR/*"
else
    mkdir -p "$INSTALL_DIR"
fi
cp -r temp_repo/* "$INSTALL_DIR"

# Очищуємо тимчасову папку
rm -rf temp_repo

echo "Мовний пакет успішно встановлено!"
