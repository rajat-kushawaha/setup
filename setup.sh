clear
printf "\n\nSetting up your MacBook......\n\n"

printf "\n-------------------->> Creating directories <<--------------------\n"
mkdir ~/root;

printf "\n-------------------->> Creating symlinks <<--------------------\n"
cp -R bin ~/root
mkdir ~/.config/
mkdir ~/.config/alacritty/
ln -s ~/root/bin/.vimrc ~/.vimrc
ln -s ~/root/bin/alacritty.yml ~/.config/alacritty/alacritty.yml

printf "\n-------------------->> Installing HomeBrew <<--------------------\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)";
brew doctor;

printf "\n-------------------->> Install Git <<--------------------\n"
brew install git;

printf "\n-------------------->> Installing ZSH <<--------------------\n"
brew install zsh zsh-autosuggestions;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;
echo "
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source ~/root/bin/aliases.sh
source ~/root/bin/tmux-aliases.sh
export PATH=~/root/bin:/usr/local/Cellar/:$PATH
" >> ~/.zshrc;

printf "\n-------------------->> Installing Spaceship Prompt <<--------------------\n"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1;
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme";
echo "
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
" >> ~/.zshrc;

printf "\n-------------------->> Installing fonts <<--------------------\n"
brew tap homebrew/cask-fonts;
brew install --cask font-fira-code;

printf "\n-------------------->> Installing command line tools <<--------------------\n"
brew install htop vim node curl bat tree npm tmux tmuxinator pgcli postgresql iredis;

printf "\n-------------------->> Updating npm global directory <<--------------------\n"
mkdir ~/root/bin/.npm-global/
npm config set prefix '~/root/bin/.npm-global'
echo "export PATH=~/root/bin/.npm-global:$PATH" >> ~/.zshrc;

printf "\n-------------------->> Installing applications <<--------------------\n"
brew install google-chrome meetingbar;
brew install --cask intellij-idea mattermost alacritty zoom latest apple-juice;

printf "\n-------------------->> Installing node modules <<--------------------\n"
npm install -g nodejs/repl;

printf "\n-------------------->> Install Programming Languages <<--------------------\n"
brew install openjdk@11;
echo 'export PATH="/usr/local/opt/openjdk@11/bin:$PATH"' >> ~/.zshrc;
sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk;
brew install clojure/tools/clojure leiningen;

printf "\n-------------------->> Setting default shell <<--------------------\n"
chsh -s /usr/local/bin/zsh;

printf "\n\n----------------\n Done...\n\n"
