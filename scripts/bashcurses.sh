!/bin/bash
source bashsimplecurses/simple_curses.sh

echo "Press 'c' for CPU (%), 'r' for RAM, 'd' for DISK USAGE, 'u' for USER  or 'q' to quit."

center_text() {
    local text="$1"
    local term_width=$(tput cols)
    local text_width=${#text}
    local padding=$(( (term_width - text_width) / 2 ))

    printf "%${padding}s%s\n" " " "$text"
}

while true; do
    # Wait for a single key press without echo
    read -n 1 -s key
    case $key in
        c)
            main(){
                CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
                window "CPU Usage" "blue"
                append "CPU : (%) ${CPU_LOAD}%"
                addsep
                append "The date command"
                append_command "date"
                endwin
            }
            main_loop
            ;;
        r)
            main(){
                FREE_MEMORY=$(free -m | grep -i mem | awk '{print $4}')
                window "RAM Usage" "blue"
                append "RAM : (MB) ${FREE_MEMORY}"
                addsep
                append "The date command"
                append_command  "date"
                endwin
            }
            main_loop
            ;;
        d)
            main(){
                DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
                window "DISK Usage" "blue"
                append "DISK : ${DISK_USAGE}%"
                addsep
                append "The date command"
                append_command "date"
                endwin
            }
            main_loop
            ;;
        u)
            main(){
                window "Users"   "blue"
                addsep
                window "Logged-in Users" "red"
                append_command "who"
                endwin
                window "User Activity" "green"
                append_command "w -h"
                endwin
            }
            main_loop
            ;;
        f)
            main(){
                CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
                window "CPU Usage" "blue"
                append "CPU : (%) ${CPU_LOAD}%"
                endwin
                FREE_MEMORY=$(free -m | grep -i mem | awk '{print $4}')
                window "RAM Usage" "blue"
                append "RAM : (MB) ${FREE_MEMORY}"
                endwin
                DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
                window "DISK Usage" "blue"
                append "DISK : ${DISK_USAGE}%"
                endwin
                window "Users"   "blue"
                addsep
                window "Logged-in Users" "red"
                append_command "who"
                endwin
                window "User Activity" "green"
                append_command "w -h"
                endwin
                append "The date command"
                append_command "date"
                endwin
            }
            main_loop
            ;;

        q)
            echo "Quitting..."
            break
            ;;
        *)
            echo "Unknown key: $key"
            ;;
    esac
done


