#!/bin/bash
echo "🚀 Iniciando aplicación PepsiCo Taller..."
echo "📊 Configurando base de datos..."

# Crear tablas si no existen
python -c "
from app import create_app
from models import db
app = create_app()
with app.app_context():
    db.create_all()
    print('✅ Tablas de BD creadas/verificadas')
    
    # Verificar si necesitamos datos iniciales
    from models import Usuario
    if not Usuario.query.filter_by(email='admin@pepsico.cl').first():
        print('🔧 Ejecutando inicialización de datos...')
        from init_db import init_roles
        init_roles()
    else:
        print('✅ BD ya inicializada')
"

echo "🌐 Iniciando servidor Flask..."
python app.py