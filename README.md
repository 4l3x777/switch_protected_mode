# Switch Protected Mode. Программа для перевода процессора в защищенный режим

## Задача - перевести процессор в защищенный режим и напечатать сообщение на экран

+ сформировать три сегментных GDT дескриптора:
  + gdt_code | base = 0x7e00 | length = 0x200 | Access: RX для сегмента кода программы в PM
  + gdt_data | base = 0x8000 | length = 0x200 | Access: RW для сегмента данных программы в PM
  + gdt_gpu | base = 0xb8000 | length = 0xffff | Access: RW для сегмента данных чтения и записи в видеопамять
+ программа состоит из 2 частей:
  + первая часть 16-bit программа для RM boot сектора, выводит сообщение из  RM, формирует GDT, загружает программу для PM
  + вторая чать 32-bit программа для PM, выводит сообщение через видеопамять

## scr_floppyA

+ содержит код программы для 16-bit RM boot сектора

## scr_floppyB

+ содержит код программы для 32-bit PM

## bin

+ protected_mode.bin - compiled scr_floppyA
+ print_protected_mode.bin - compiled scr_floppyB
+ bochsrc.bxrc - bochs config

## Для проверки корректной работы необходимо

+ ```bochs-2.6.9``` or later
+ ```fasm``` compiler
+ ```fasm-editor``` IDE
+ ```gdt_descriptor_builder``` для формирования нужного GDT дескриптора <https://github.com/4l3x777/gdt_descriptor_builder>

## Пример работы

![alt text](/img/protected_mode.gif)

