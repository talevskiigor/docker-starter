#!/bin/bash


if [ -z ${PHP_VERSION+x} ]; then
    echo -e "\n Please select version for PHP"
    PS3='Please enter your choice: '
    options=("PHP 8.2" "PHP 8.1" "PHP 8.0" "PHP 7.4" "PHP 5.6" "EXIT")
    select opt in "${options[@]}"; do
        case $opt in
            "PHP 8.2")
                PHP_VERSION="8.2"
                break
            ;;
            "PHP 8.1")
                PHP_VERSION="8.1"
                break
            ;;
            "PHP 8.0")
                PHP_VERSION="8.0"
                break
            ;;
            
            "PHP 7.4")
                PHP_VERSION="7.4"
                break
            ;;
            
            "PHP 5.6")
                PHP_VERSION="5.6"
                break
            ;;
            
            "EXIT")
                break
            ;;
            *) echo "invalid option $REPLY" ;;
        esac
    done
    
    export PHP_VERSION="${PHP_VERSION}"
fi
