#!/bin/bash

# Оголошення змінних
REPO_URL="https://github.com/Vova-Bob/aaPanel---Ukrainian-Language-pak/archive/refs/heads/main.zip"
INSTALL_PATH="/www/server/panel"
TEMP_PATH="/tmp/aaPanel-ua"
ARCHIVE_NAME="aaPanel-ua.zip"

# Функція для виведення помилок
error_exit() {
    echo "$1" >&2
    exit 1
}

echo "Перевірка наявності wget або curl..."
if command -v wget >/dev/null 2>&1; then
    DOWNLOADER="wget"
elif command -v curl >/dev/null 2>&1; then
    DOWNLOADER="curl"
else
    error_exit "Необхідно встановити wget або curl."
fi

# Завантаження архіву з мовним пакетом
echo "Завантаження мовного пакету..."
if [ "$DOWNLOADER" == "wget" ]; then
    wget $REPO_URL -O $TEMP_PATH/$ARCHIVE_NAME || error_exit "Помилка завантаження мовного пакету."
else
    curl -L $REPO_URL -o $TEMP_PATH/$ARCHIVE_NAME || error_exit "Помилка завантаження мовного пакету."
fi

echo "Архів успішно завантажено."

# Створення тимчасової директорії
mkdir -p $TEMP_PATH

# Розпакування архіву
echo "Розпакування архіву..."
unzip -o $TEMP_PATH/$ARCHIVE_NAME -d $TEMP_PATH || error_exit "Помилка розпакування архіву."

# Копіювання локалізаційних файлів до панелі aaPanel
echo "Копіювання файлів перекладу до $INSTALL_PATH..."
cp -r $TEMP_PATH/aaPanel---Ukrainian-Language-pak-main/* $INSTALL_PATH/ || error_exit "Помилка копіювання файлів."

# Видалення тимчасових файлів
rm -rf $TEMP_PATH

echo "Встановлення завершено. Перейдіть в налаштування aaPanel і виберіть українську мову."

