#!/bin/bash

# Визначаємо URL для скачування
REPO_URL="https://github.com/Vova-Bob/aaPanel---Ukrainian-Language-pak"
LANGUAGE_PACK="BTPanel"

# Директорія для установки
INSTALL_DIR="/www/server/panel/$LANGUAGE_PACK"

# Перевірка наявності прав на запис у директорію
if [ ! -w "/www/server/panel/" ]; then
    echo "Помилка: у вас немає прав на запис до директорії /www/server/panel/. Використайте sudo для запуску скрипта."
    exit 1
fi

# Завантажуємо файли з репозиторію
echo "Завантаження мовного пакету aaPanel-Ukrainian-Language-pak..."
if command -v git &> /dev/null; then
    # Якщо git доступний, клонуємо репозиторій
    git clone --depth=1 "$REPO_URL" temp_repo
else
    echo "git не знайдено, спробуємо використати wget для завантаження."
    wget -q -O temp_repo.zip "$REPO_URL/archive/refs/heads/main.zip"
    unzip -q temp_repo.zip
    mv "aaPanel---Ukrainian-Language-pak-main/BTPanel" temp_repo
    rm -rf aaPanel---Ukrainian-Language-pak-main temp_repo.zip
fi

# Копіюємо лише потрібні файли до директорії aapanel
echo "Копіювання мовного пакету до $INSTALL_DIR..."
if [ -d "$INSTALL_DIR" ]; then
    # Заміна файлів у разі наявності
    rm -rf "$INSTALL_DIR/*"
else
    mkdir -p "$INSTALL_DIR"
fi

# Копіюємо тільки потрібні файли (без LICENSE, README.md, ua_language_pack.sh)
shopt -s extglob
cp -r temp_repo/!(LICENSE|README.md|ua_language_pack.sh)/* "$INSTALL_DIR/" || {
    echo "Помилка при копіюванні файлів до $INSTALL_DIR."
    exit 1
}

# Очищуємо тимчасову папку
rm -rf temp_repo

# Повідомлення про успішну установку та інструкції
echo -e "Мовний пакет 'Українська' успішно встановлено!\n\n"
echo "Щоб змінити мову, ви можете зробити наступне:"
echo "1. Перейдіть на головну сторінку aaPanel."
echo "2. У верхній правій частині екрану натисніть на перемикач мови та виберіть 'Українська'."
echo "Або"
echo "3. Натисніть на 'Налаштування'."
echo "4. Перейдіть до вкладки 'Мова'."
echo "5. У випадаючому списку виберіть 'Українська', щоб змінити мову панелі на українську."
