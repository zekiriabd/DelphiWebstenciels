# Utiliser une image de base Ubuntu plus récente
FROM ubuntu:22.04

# Installer Wine, Xvfb, Wine Gecko, et les dépendances
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    wine32 \
    wine64 \
    xvfb \
    unixodbc \
    unixodbc-dev \
    wget \
    cabextract \
    winbind \
    && rm -rf /var/lib/apt/lists/*

# Installer Wine Gecko et Wine Mono pour les composants requis par Wine
RUN wget https://dl.winehq.org/wine/wine-gecko/2.47.2/wine-gecko-2.47.2-x86.msi && \
    wget https://dl.winehq.org/wine/wine-gecko/2.47.2/wine-gecko-2.47.2-x86_64.msi && \
    wget https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.msi && \
    wine64 msiexec /i wine-gecko-2.47.2-x86_64.msi && \
    wine msiexec /i wine-gecko-2.47.2-x86.msi && \
    wine64 msiexec /i wine-mono-7.0.0-x86.msi

# Créer un répertoire de travail pour l'application
WORKDIR /wwwroot

# Copier les fichiers de l'application dans le conteneur
COPY . .

# Donner les permissions d'exécution à l'exécutable de l'application
RUN chmod +x ./PWA_Delphi.exe

# Exposer les ports nécessaires
EXPOSE 80
EXPOSE 443

# Lancer Xvfb en arrière-plan puis exécuter l'application avec Wine
ENTRYPOINT ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & DISPLAY=:99 wine ./PWA_Delphi.exe -no-gui"]
