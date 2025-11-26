cd /home/LV/UTN-FRA_SO_Examenes/202411/ansible/roles/
ansible-galaxy role init Crea_Carpetas_Velozo
ansible-galaxy role init Cambia_Propiedad_Velozo
ansible-galaxy role init Sudoers_Velozo
cd 2PRecuperatorio/task
rm main.yml
cat << FIN >> main.yml
# tasks file for 2PRecuperatorio

 - name: "Rol: 2PRecuperatorio"
   debug:
    msg: "Inicio de tareas dentro del Rol: 2PRecuperatorio"

 - name: "creo Grupos"
   become: yes
   ansible.builtin.group:
    name: "{{ item }}"
    state: present
   with_items:
    - GProfesores
    - GAlumnos

 - name: "creo usuarios Profesor"
   ansible.builtin.user:
    name: Profesor
    create_home: yes
    groups: GProfesores

 - name: "creo usuarios Profesor"
   ansible.builtin.user:
    name: Alumno
    create_home: yes
    groups: GAlumnos
FIN
cd ..
cd ..
cd Crea_Carpetas_Velozo/task/
cat << FIN >> main.yml
# tasks file for Crea_Carpetas_Velozo

 - name: "Crear directorios en el directorio raíz"
   file:
    path: "/UTN/{{ item }}"
    state: directory
    mode: '0775'
    recurse: yes
   with_items:
    - "Alumno"
    - "Profesor"
FIN
cd ..
cd ..
cd Cambia_Propiedad_velozo/task/
cat << FIN >> main.yml
# tasks file for Cambia_Propiedad_Velozo

 - name: Cambiar propietario y grupo de /UTN/Alumno
   file:
    path: /UTN/Alumno
    owner: Alumno
    group: GAlumnos
    state: directory

 - name: Cambiar propietario y grupo de /UTN/Profesor
   file:
    path: /UTN/Profesor
    owner: Profesor
    group: GProfesores
    state: directory
FIN
cd ..
cd ..
cd Sudoes_Velozo/task/
cat << FIN >> main.yml
# tasks file for Sudoers_Velozo

 - name: "add NOPASSWD in sudores for group {{ GROUP_ADMIN }}"
   become: yes
   lineinfile:
    path: /etc/sudoers
    state: present
    regexp: '^%GProfesores'
    line: '%GProfesores ALL=(ALL) NOPASSWD: ALL'
    validate: 'visudo -cf %s'
FIN
cd ..
cd ..
cd ..
rm playbook.yml
cat << FIN >> playbook.yml
---
- hosts: localhost
  become: yes
  roles:

  tasks:
    - include_role:
        name: 2PRecuperatorio
    - include_role:
        name: Crea_Carpetas_Velozo
    - include_role:
        name: Cambia_Propiedad_Velozo
    - include_role:
        name: Sudoers_Velozo
    - name: "Otra tarea"
      debug:
        msg: "Despues de la ejecucion del rol"
FIN

ansible-playbook playbook.yml
