for pgsqlVer in {13..18}; do
  if [[ -d "$(brew --prefix)/opt/postgresql@${pgsqlVer}/bin" ]]; then
  	info "🗃 Setup PATH: PostgreSQL@${pgsqlVer}"
  	export PATH="$(brew --prefix)/opt/postgresql@${pgsqlVer}/bin:$PATH"
  	break
  fi
done
