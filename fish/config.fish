if status is-interactive
    # Commands to run in interactive sessions can go here

   fish_add_path ~/bin

   alias windesktop="cd /mnt/c/Users/micha/Desktop"
   alias dev="cd /mnt/d/Development"
   alias windl="cd /mnt/c/Users/micha/Downloads"
   alias config="vim ~/.config/fish/config.fish"
   alias n="npm run"

   # Load nvm
   nvm > /dev/null
end

