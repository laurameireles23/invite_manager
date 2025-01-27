# Imagem base
FROM ruby:3.2.2

# Adicionar repositórios do Node.js e Yarn
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Instalar dependências
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    postgresql-client

# Definir diretório de trabalho
WORKDIR /app

# Copiar Gemfile e instalar gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copiar o resto da aplicação
COPY . .

# Adicionar script de inicialização
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expor porta 3000
EXPOSE 3000

# Iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]