FROM node:18-alpine

# Créer un utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm ci --only=production

# Copier le code source
COPY --chown=nodejs:nodejs src/ ./src/
# Changer vers l'utilisateur non-root
USER nodejs

EXPOSE 3000

CMD ["node", "src/index.js"]