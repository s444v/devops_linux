# Отчет по проекту "Операционные системы UNIX/Linux (Базовый)."

## Содержание
1. [Part 1](#part-1-установка-oc)
2. [Part 2](#part-2-создание-пользователя)
3. [Part 3](#part-3-настройка-сети-oc)
4. [Part 4](#part-4-обновление-oc)
5. [Part 5](#part-5-настройка-сети-oc)
6. [Part 6](#part-6-установка-и-настройка-службы-времени)
7. [Part 7](#part-7-установка-и-использование-текстовых-редакторов)
8. [Part 8](#part-8-установка-и-базовая-настройка-сервиса-sshd)
9. [Part 9](#part-9-установка-и-использование-утилит-top-htop)
10. [Part 10](#part-10-использование-утилиты-fdisk)
11. [Part 11](#part-11-использование-утилиты-df)
12. [Part 12](#part-12-использование-утилиты-du)
13. [Part 13](#part-13-установка-и-использование-утилиты-fncdu)
14. [Part 14](#part-14-работа-с-системными-журналами)
15. [Part 15](#part-15-использование-планировщика-заданий-cron)

## Part 1. Установка OC

![linux](src/images/part1.jpg)
>Консоль с выводом версии ubuntu.

## Part 2. Создание пользователя

![linux](src/images/part2.jpg)
>Консоль с созданием нового юзера.

![linux](src/images/part2_2.jpg)
>Консоль с выводом etc/passwd и группы adm.

## Part 3. Настройка сети OC

 - `sudo vim /etc/hostname` (изменение вручную имя хоста).
 - `sudo timedatectl set-timezone Europe/Moscow` (для установки часового пояса).
 - `ifconfig` (консольная команда для вывода сетевых интерфейсов и информации по ним).
 lo (loopback device) – виртуальный интерфейс, присутствующий по умолчанию в любом Linux. Он используется для отладки сетевых программ и запуска серверных приложений на локальной машине. С этим интерфейсом всегда связан адрес 127.0.0.1.
 - `wget -qO- ifconfig.me` команда для вывода внешнего ip 

 ![linux](src/images/part3_ip.jpg)
> Консоль с выводом команды ip route.

 - Чтобы задать статичные настройки ip, gw, dns нужно отредактировать по пути  etc/netplan с расширением .yaml
 для использование публичных DNS серверов в том же файле нужно добавить addresses: [8.8.8.8]. Также нужно принять изменения командой sudo netplan apply.

![linux](src/images/part3_ping.jpg)
>Консоль с пингами двух хостов. 



## Part 4. Обновление OC

![linux](src/images/part4.jpg)
>Консоль с информацией об наличии обновлений. 

## Part 5. Использование команды sudo
 - `usermod -a -G sudo second`  команда для выдачи прав пользователю.
 - Substitute User and do, дословно «подменить пользователя и выполнить»

 ![linux](src/images/part5.jpg)
>Изменение hostname 


## Part 6. Установка и настройка службы времени

 ![linux](src/images/part6_time.jpg)
>Вывод времени.

 ![linux](src/images/part6_show.jpg)
>Вывод команды timedatectl show.

## Part 7. Установка и использование текстовых редакторов

- vim = :wq    nano = ctrl+q     mcedit = save + quit

 ![linux](src/images/part7_vim_1.jpg)
>VIM.

 ![linux](src/images/part7_nano_1.jpg)
>NANO.

 ![linux](src/images/part7_mc_1.jpg)
>MCEDIT.

- vim = :q!    nano = ctrl+x     mcedit = quit + no

 ![linux](src/images/part7_vim_2.jpg)
>VIM.

 ![linux](src/images/part7_nano_2.jpg)
>NANO.

 ![linux](src/images/part7_mc_2.jpg)
>MCEDIT.

- vim = /     
- nano = Нажимте Ctrl+\, введите строку, которую необходимо искать и нажмите клавишу Enter. Затем введите строку, на которую произвести замену и нажмите Enter.
- mcdeit = интуитивно понятные кнопки в консоли search и replace.

 ![linux](src/images/part7_vim_3_s.jpg)
>VIM search.

 ![linux](src/images/part7_vim_3_r.jpg)
>VIM replace.

 ![linux](src/images/part7_nano_3_s.jpg)
>nano search.

 ![linux](src/images/part7_nano_3_r.jpg)
>nano replace.

 ![linux](src/images/part7_mc_3_s.jpg)
>mcedit search.

 ![linux](src/images/part7_mc_3_r.jpg)
>mcedit replace.

## Part 8. Установка и базовая настройка сервиса SSHD
- `sudo apt install openssh-server` команда для установки sshd.
- `sudo systemctl enable sshd` команда для автостарта службы.
- `vim /etc/ssh/sshd_config` открываем конфиг и меняем строку Port на Port 2022.
- `ps -A | grep ssh` флаг -A выводит все процессы.

 ![linux](src/images/part8.jpg)
>Вывод команды netstat -tan.

 -  -t  по протоколу TCP; -a Показывать состояние всех сокетов; обычно сокеты, используемые серверными процессами, не показываются. ; -n  без резолва IP/имён

## Part 9. Установка и использование утилит top, htop
  - uptime = 0.16.40    
  - количество авторизованных пользователей = 1
  - общую загрузку системы = 0.24
  - общее количество процессов = 101 
  - загрузку cpu = 2.5%
  - загрузку памяти = 4871mb
  - pid процесса занимающего больше всего памяти = 5289
  - pid процесса, занимающего больше всего процессорного времени = 2142

 ![linux](src/images/part9_11.jpg)
>вывод top

 ![linux](src/images/part9_pid.jpg)
>сортировка по pid.

 ![linux](src/images/part9_cpu.jpg)
>сортировка по cpu.

 ![linux](src/images/part9_mem.jpg)
>сортировка по mem.

 ![linux](src/images/part9_time.jpg)
>сортировка по time.

 ![linux](src/images/part9_sshd.jpg)
>фильтр по sshd.

 ![linux](src/images/part9_sys.jpg)
>поиск syslog.

 ![linux](src/images/part9_up.jpg)
>вывод hostname clock uptime.

## Part 10. Использование утилиты fdisk

 ![linux](src/images/part10.jpg)
>название жесткого диска, его размер и количество секторов.

 ![linux](src/images/part10_1.jpg)
>размер swap.

## Part 11. Использование утилиты df

 ![linux](src/images/part11_df.jpg)
>корневой раздел в байтах.

 ![linux](src/images/part11_df_2.jpg)
>ext4 (англ. fourth extended file system, ext4fs) — журналируемая файловая система.

## Part 12. Использование утилиты du

 ![linux](src/images/part12_home.jpg)
>папка home.

 ![linux](src/images/part12_var.jpg)
>папка var.

 ![linux](src/images/part12_varlog.jpg)
>папка log.

 ![linux](src/images/part12_varlog_all.jpg)
>папка log каждого элемента .


## Part 13. Установка и использование утилиты ncdu

 ![linux](src/images/part13_home.jpg)
>папка home.

 ![linux](src/images/part13_var.jpg)
>папка var.

 ![linux](src/images/part13_varlog.jpg)
>папка log.

## Part 14. Работа с системными журналами

 ![linux](src/images/part14_login.jpg)
>время авторизации.

 ![linux](src/images/part14_restart.jpg)
>restart службы sshd.


## Part 15. Использование планировщика заданий CRON

 ![linux](src/images/part15_1.jpg)
>запись в планировщик.

 ![linux](src/images/part15_2.jpg)
>выполненые две задачи.

 ![linux](src/images/part15_3.jpg)
>удаление всех задач.