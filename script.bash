# Prosty program który sprawdza jakie tty (terminale) są otwarte na pisanie po nich, i jeśli właścicielem jest student, to pisze określone rzeczy
# oczywiście wszystko w celach edukacyjnych, wiele ciekawych rzeczy można było się dowiedzieć realizując ten "projekt"
# ewentualnie dorobić rozbicie na dwa programy, ale w tedy może być problem, bo nie tak łatwo będzie to zatrzymać

# samo skanowanie przebiegło pomyślnie równeż testy na zaprzyjaźnionym koledze w pokoju, wiedzący co się będzie działo. oczywiśce ktoś celowo może mieć ustawiony terminal do pisania
# niemniej, raczej nie powinien
# ciekawym zastosowaniem, byłoby np zmodyfikowanie skryptu np o osoby z danej grupy piszącej kolokwium, przy próbie "oszustwa" (ktoś wysyła innym przez terminal rozwiązania" można byłoby 
podnieść ciśnienie zdającym.

# aby wysyłało wiadomości należy odkomendować linijkę 52 : #send_message &

#!/bin/bash
open_tty=$(ls -al /dev/pts | grep -E "^.{5}w" | tr -s ' ' '_') # otwarte tty, i zamiana " " na "_" aby for dobrze działał
trap "echo -e '\nzakoczyles program'; exit;" SIGINT
trap "echo 'wiadomość, usunąłeś zawartość loga' " SIGUSR1
echo -e "otwarte tty:\n$open_tty"
send_message () {
        echo "tty to $nr_tty"
        echo -e "\n\nPrawdopodobnie masz błąd za chwilę dowiesz się jaki\n\n" > /dev/pts/$nr_tty
        sleep 1
        for i in {5..0}
        do
                if [ $i == 0 ]
                then
                echo -e "twój terminal open_tty jest otwarty na pisanie, KAŻDY może po nim pisać, masz 20s na wyłączenie tego...\nnp: chmod 700 /dev/pts/$nr_tty " > /dev/pts/$nr_tty
                break
                fi
                echo "$i" > /dev/pts/$nr_tty
                sleep 1
        done
        sleep 18
        echo -e "Sam tego chciałeś..." > /dev/pts/$nr_tty
        echo "IDZIE"
        sleep 2
        while [ true ]
        do
                echo -e "\033[1;32m$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM" > /dev/pts/$nr_tty
        done
}

for linia in $open_tty
do
        #echo "$linia"
        s_user=$( echo "$linia" | cut -d '_' -f 3)
        #echo "user to: $s_user"
        if [ "$(groups $s_user | cut -d ' ' -f 3)" == "students" ]
        then

                nr_tty=$(echo "$linia" | cut -d '_' -f 6)
                echo "$s_user, tty: $nr_tty"
                echo "$nr_tty"
               # send_message &
        else
                echo "$s_user NIE JEST"
        fi
done

while [ true ]
do
        sleep 1 # aby można było zastopować
done