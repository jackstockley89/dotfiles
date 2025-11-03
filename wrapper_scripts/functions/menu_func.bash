#!/bin/bash

working_directory(){
  cd ~/.wrapper_scripts
}

input_error(){
  echo -e $(ColorRed "Invalid option. Please try again.") ; 
  if [ $1 == "overview_menu" ]; then
    overview_menu
  elif [ $1 == "script_menu" ]; then
    script_menu
  fi
}

menu_list(){
  arr=("$@")
  # if the array is empty dont error out
  if [ ${#arr[@]} -eq 0 ]; then
    echo -e $(ColorRed "No scripts found in this directory. Returning to Main Menu.") ;
    overview_menu
  fi
  
  # arr is an array passed from script menus 
  # below will create a list from the array and offset the index by 1
  for i in "${!arr[@]}"; do
      echo "  $(ColorGreen "$((i))") ${arr[$i]}"
  done
}

overview_menu(){
  working_directory
  overview_arr=(`find ~/.wrapper_scripts/* -maxdepth 1 -type d ! -path ~/.wrapper_scripts/functions -exec basename {} \;`)
  echo -e "\n$(ColorGreen "Directories in ~/.wrapper_scripts:")"
  menu_list "${overview_arr[@]}"
  echo "  $(ColorGreen "e") exit"
  read -p " $(ColorBlue "Enter the number of the directory to enter: ")" directory_number

  case $directory_number in
    e)
      echo -e $(ColorGreen "Goodbye!") ;
      exit 0
      ;;
    $directory_number)
      echo -e $(ColorGreen "Entering ${overview_arr[$((directory_number))]}") ;
      cd ~/.wrapper_scripts/${overview_arr[$((directory_number))]} ;
      script_menu
      ;;
    *)
      input_error "overview_menu"
      ;;
  esac
  
}

script_menu(){
  current_dir=$(pwd)
  script_arr=(`find $current_dir/* -maxdepth 1 -type f ! -path "$current_dir/go.*" -exec basename {} \;`)
  echo -e "\n$(ColorGreen "Scripts in $current_dir:")"
  menu_list "${script_arr[@]}"
  echo "  $(ColorGreen "m") main menu"
  echo "  $(ColorGreen "e") exit"
  read -p " $(ColorBlue "Enter the number of the script to run: ")" script_number
  
  case $script_number in
    m)
      echo -e $(ColorGreen "Returning to Main Menu") ;
      overview_menu
      ;;
    e)
      echo -e $(ColorGreen "Goodbye!") ;
      exit 0
      ;;
    $script_number)

      if [[ $current_dir =~ "shell" ]]; then
        bash $current_dir/${script_arr[$((script_number))]} ;
        script_menu
      elif [[ $current_dir =~ "go" ]]; then
        go run $current_dir/${script_arr[$((script_number))]} ;
        script_menu
      else
        echo -e $(ColorRed "Invalid option") ;
        script_menu
      fi
      ;;
    *)
      input_error "script_menu"
      ;;
  esac
}