#!/bin/bash
clear

##################If nothing is passed as an argument these options appears for the user################
if [ -z $1 ]
then
echo "Please Choose an Option :)"
echo "1-Add a New Contact          [-i]"
echo "2-Display All Contacts       [-v]"
echo "3-Search Contacts by Name    [-s]"
echo "4-Delete All Contacts        [-e]"
echo "5-Delete One Contact by Name [-d]"

##################################" -i " for adding a new contact#######################################
elif [ $1 = '-i' ]
then

if [ ! -f ".phonebookDB.txt" ]
then
touch .phonebookDB.txt
fi

checknumber=0
flag=0
checknumber2=11
flag2=1			##initialized values that doesn't affect the code but only satisfies the inital while conditions
countphone2=0
phone2=011

while [[ $checkname -ge 40 ]] || [[ $checknumber -ne 11 ]] || [[ ${phone:0:1} != '0' ]] || [[ $flag -eq 0 ]] || [[ ${name:0:1} = [0-9] ]] || [[ $countphone -ne 0  ]] || [[ $checknumber2 -ne 11 ]] || [[ ${phone2:0:1} != '0' ]] || [[ $flag2 -eq 0 ]] || [[ $countphone2 -ne 0 ]] 
do

read -p "Please enter the contact's Full-Name [40 Characters Max]: " name 
read -p "Please enter the phone-number of the contact: " phone 
read -p "Press Y for adding another phone-number and any other key for not adding: " add 

if [ $add = 'Y' ]
then
read -p "Please enter the 2nd phone-number of the contact: " phone2 
checknumber2=${#phone2}
fi

checkname=${#name}
checknumber=${#phone}

if [[ checkname -ge 40 ]]
then
echo "You exceeded the Full-Name's limit, please try again !" 	##Verifying that the full name must be at max 40 characters
fi

if [[ ${name:0:1} = [0-9] ]]
then
echo "Contact's name can't start with a digit"			##Verifying that the name can not start with a digit		
fi

if [[ checknumber -ne 11 ]]
then
echo "Invalid Phone-Number Size, Must be 11 digits, please try again"	##Verifying that the phone number must be 11 digits exactly
fi

if [[ ${phone:0:1} != '0' ]]
then
echo "Phone Number must start with 0, please try again"		##Verifying that the phone number must start with ' 0 '
fi

if [[ $phone =~ ^[0-9]+$ ]]
then
flag=1
else								 ##Verifying that the phone number must include only digits from 0-9
flag=0
echo "Phone Number must include only digits from 0-9 !!, please try again"
fi

#countname=`grep "$name" .phonebookDB.txt|wc -l`
#if [ $countname -ne 0 ]
#then								##verifying if the name is unique and not added before
#echo "The name you entered was found in the phonebook, please try again"
#fi

countphone=`grep "$phone" .phonebookDB.txt|wc -l`
if [ $countphone -ne 0 ]
then								##verifying if the phone is unique and not added before
echo "The phone you entered belongs to another contact in the PB, please try again"
fi

if [ $add = 'Y' ]
then

if [[ checknumber2 -ne 11 ]]
then
echo "Invalid 2nd Phone-Number Size, Must be 11 digits, please try again"	##Verifying that the phone number must be 11 digits exactly
fi

if [[ ${phone2:0:1} != '0' ]]
then
echo "2nd Phone Number must start with 0, please try again"		##Verifying that the phone number must start with ' 0 '
fi

if [[ $phone2 =~ ^[0-9]+$ ]]
then
flag2=1
else								 ##Verifying that the phone number must include only digits from 0-9
flag2=0
echo "2nd Phone Number must include only digits from 0-9 !!, please try again"
fi

countphone2=`grep "$phone2" .phonebookDB.txt|wc -l`
if [ $countphone2 -ne 0 ]
then								##verifying if the phone is unique and not added before
echo "The 2nd phone you entered belongs to another contact in the PB, please try again"
fi

fi

done

if [ $add = 'Y' ]
then
echo  -n "Name: $name ---- Phone: ">>.phonebookDB.txt
echo -n $phone>>.phonebookDB.txt
echo -n " ---- Phone2: ">>.phonebookDB.txt
echo $phone2>>.phonebookDB.txt
echo "Contact Added Successfully!"
else
echo  -n "Name: $name ---- Phone: ">>.phonebookDB.txt
echo $phone>>.phonebookDB.txt
echo "Contact Added Successfully!"
fi
       
#######################" -v " for Printing all the contacts in the phonebook############################
elif [ $1 = '-v' ]
then
if [ -s .phonebookDB.txt ]
then
echo "The phonebook includes: " 
echo
cat .phonebookDB.txt
else
echo "The PhoneBook is empty at the moment!"
fi

#######################" -s " for searching by name in the phonebook####################################
elif [ $1 = '-s' ]
then
read -p "Please enter the name that you want to search for in the phonebook: " sname
grep "$sname" .phonebookDB.txt
count=`grep "$sname" .phonebookDB.txt|wc -l`
if [ $count -eq 0 ]
then						##verifying if no matches found
echo "The name you entered has no matches in the phonebook"
fi

#######################" -e " for Deleting all the records from the phonebook###########################
elif [ $1 = '-e' ]
then
>.phonebookDB.txt
echo "All of the Contacts were deleted successfully!!"

#######################" -d " for deleting one record from the phonebook################################
elif [ $1 = '-d' ]
then
read -p "Please enter the name that you want to delete from the phonebook: " tname
									#First greps the matching names then allows
grep "$tname" .phonebookDB.txt						#the user to enter the full name again to
									#avoid the deletion of multiple contacts :)

count=`grep "$tname" .phonebookDB.txt|wc -l`				
if [ $count -eq 0 ]							##verifying if no matches found			
then						
echo "The name you entered has no matches in the phonebook"
else
echo 
echo "The previous contact(s) are matching the name you entered!" 						
echo 									
echo "please enter the exact full-name that you want to delete to avoid deleting"
echo "other contacts incorrectly!!"
echo
read -p "Please enter the exact name that you want to delete from the phonebook: " dname
sed -i "/$dname/d" .phonebookDB.txt
fi

#######################If the users entered an invalid argument#########################################
else
echo "You entered an Invalid option !"
echo "Please Choose an Option :)"
echo "1-Add a New Contact          [-i]"
echo "2-Display All Contacts       [-v]"
echo "3-Search Contacts by Name    [-s]"
echo "4-Delete All Contacts        [-e]"
echo "5-Delete One Contact by Name [-d]"
fi

