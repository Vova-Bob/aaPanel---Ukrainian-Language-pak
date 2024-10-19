#!/bin/bash

# Оголошення змінних
REPO_URL="https://raw.githubusercontent.com/Vova-Bob/aaPanel---Ukrainian-Language-pak/main/BTPanel"
INSTALL_PATH="/www/server/panel"

# Функція для виведення помилок
error_exit() {
    echo "$1" >&2
    exit 1
}

# Створення тимчасової директорії
TEMP_PATH=$(mktemp -d)

echo "Завантаження мовного пакету..."

# Завантаження файлів з репозиторію
if command -v wget >/dev/null 2>&1; then
    wget -r -np -nH --cut-dirs=3 -P $TEMP_PATH $REPO_URL || error_exit "Помилка завантаження мовного пакету."
else
    curl -L $REPO_URL -o $TEMP_PATH || error_exit "Помилка завантаження мовного пакету."
fi

echo "Файли успішно завантажені."

# Копіювання локалізаційних файлів до панелі aaPanel
echo "Копіювання файлів перекладу до $INSTALL_PATH..."
cp -r $TEMP_PATH/BTPanel/* $INSTALL_PATH/ || error_exit "Помилка копіювання файлів."

# Видалення тимчасових файлів
rm -rf $TEMP_PATH

echo "Встановлення завершено. Перейдіть в налаштування aaPanel і виберіть українську мову."
