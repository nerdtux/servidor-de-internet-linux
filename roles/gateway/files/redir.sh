# Editar x.x.x.x para ip destino
# -laddr é ip de origem externa
# Após --lport editar porta de origem
# Após --cport editar porta de destivo

redir -laddr=0.0.0.0 --lport 5 --caddr=x.x.x.x --cport 3 &
redir -laddr=0.0.0.0 --lport 2 --caddr=x.x.x.x --cport 1 &
redir -laddr=0.0.0.0 --lport 3 --caddr=x.x.x.x --cport 8 &
redir -laddr=0.0.0.0 --lport 3 --caddr=x.x.x.x --cport 1 &
redir -laddr=0.0.0.0 --lport 3 --caddr=x.x.x.x --cport 3 &
redir -laddr=0.0.0.0 --lport 4 --caddr=x.x.x.x --cport 1 &
redir -laddr=0.0.0.0 --lport 3 --caddr=x.x.x.x --cport 3 &
redir -laddr=0.0.0.0 --lport 5 --caddr=x.x.x.x --cport 3 &
redir -laddr=0.0.0.0 --lport 8 --caddr=x.x.x.x --cport 8 &
  
