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
wget -r -np -nH --cut-dirs=3 -P "$INSTALL_PATH" "$REPO_URL/" || {
    echo "Помилка: Не вдалося завантажити файли з $REPO_URL" >&2
    echo "Перевірте URL, доступ до інтернету або права доступу." >&2
    echo "Додаткова інформація:"
    echo "================================="
    echo "HTTP статус: $?"  # Додаємо статус HTTP
    echo "Остання команда: wget -r -np -nH --cut-dirs=3 -P $INSTALL_PATH $REPO_URL/"
    exit 1
}

# Перевірка наявності завантажених файлів
if [ -z "$(ls -A $INSTALL_PATH)" ]; then
    echo "Помилка: Директорія $INSTALL_PATH пуста. Завантаження не вдалося." >&2
    exit 1
fi

echo "Файли успішно завантажені."
echo "Встановлення завершено. Перейдіть в налаштування aaPanel і виберіть українську мову."
