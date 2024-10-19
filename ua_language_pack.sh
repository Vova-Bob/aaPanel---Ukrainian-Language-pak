#!/bin/bash

# Оголошення змінних
REPO_URL="https://github.com/Vova-Bob/aaPanel---Ukrainian-Language-pak"
INSTALL_PATH="/www/server/panel"
TEMP_PATH="/tmp/aaPanel-ua"

echo "Клонування репозиторію з українським перекладом..."

# Клонування репозиторію до тимчасової директорії
git clone $REPO_URL $TEMP_PATH

# Перевірка на успішність клонування
if [ $? -eq 0 ]; then
  echo "Репозиторій успішно скопійовано."
else
  echo "Помилка клонування репозиторію. Перевірте URL."
  exit 1
fi

# Копіювання локалізаційних файлів до панелі aaPanel
echo "Копіювання файлів перекладу до $INSTALL_PATH..."
cp -r $TEMP_PATH/* $INSTALL_PATH/

# Перевірка на успішність копіювання
if [ $? -eq 0 ]; then
  echo "Файли успішно скопійовані."
else
  echo "Помилка копіювання файлів."
  exit 1
fi

# Видалення тимчасових файлів
rm -rf $TEMP_PATH

echo "Встановлення завершено. Перейдіть в налаштування aaPanel і виберіть українську мову."
