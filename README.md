# WIndows_Stuff
Cyber Patriot Windows materials
**ORDER OF OPERATIONS-**

1. Boot machines, enter team ID, etc.
2. Review README
3. Write down admin passwords, save README
4. Answer Forensics
5. Configure powershell/script
  -launch with admin privs
  -enter "set-executionpolicy remote-signed or set-executionpolicy unrestricted"
  -set user variable from top of "winscript.ps1" to username of current admin account
  -review necessary services and comment out the removals in script if needed
  -add Win10Firewall(2).wfw to Desktop directory of current admin account
6. run "./winscript.ps1"
7. Review "scripterino" directory
8. If **ADAM** says 2nd script is operational, run it as a .bat
9. Script does not handle user rights. Configure manually.
10. Proceed with checklist, completing what the script did not
11. Review the notes/tips section of the checklist
