#!/bin/bash

# Оголошення змінних
INSTALL_PATH="/www/server/panel/BTPanel"
REPO_URL="https://raw.githubusercontent.com/Vova-Bob/aaPanel---Ukrainian-Language-pak/main/BTPanel"

# Функція для виведення помилок
error_exit() {
    echo "$1" >&2
    exit 1
}

# Створення директорії для встановлення, якщо вона не існує
mkdir -p "$INSTALL_PATH"

echo "Завантаження мовного пакету..."

# Завантаження всіх файлів з репозиторію в потрібну директорію
wget -q -r -np -nH --cut-dirs=3 -P "$INSTALL_PATH" "$REPO_URL/" || error_exit "Помилка завантаження мовного пакету."

echo "Файли успішно завантажені."

echo "Встановлення завершено. Перейдіть в налаштування aaPanel і виберіть українську мову."
