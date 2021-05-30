create table proyecto.authority(
	name varchar(50) not null,
	constraint pk_authority PRIMARY KEY (name)
);

create table proyecto.system_user1(
	id int4 not null,
    login varchar(50) not null,
	password varchar(60) not null,
	email varchar(254) not null,
	activated int4 null,
	lang_key varchar(6) not null,
	image_url varchar(256) null,
	activation_key varchar(20) null,
	reset_key varchar(20) null,
	reset_date varchar(20) null,
	constraint uk_login UNIQUE (login),
	constraint uk_email UNIQUE (email),
	constraint pk_system_user PRIMARY KEY (id)
);

create table proyecto.user_authority(
	name_rol varchar(50) not null,
	id_system_user int4 not null,
	constraint pk_user_authority primary key (name_rol, id_system_user),
	constraint fk_auth_usau foreign key (name_rol) references proyecto.authority(name),
	constraint fk_syus_usau foreign key (id_system_user) references proyecto.system_user1(id)
);

create table proyecto.ingresos_ocasionales(
	id int4 not null,
	nombre_ingreso varchar(50) null,
	frecuencia int null,
	cantidad int null,
	constraint pk_ingresos_ocasionales primary key(id)
);

create table proyecto.ingresos(
	id int4 not null,
	id_user int4 not null,
	id_ingresos_ocasionales int4 not null,
	salario_fijo int not null,
	total_ingresos int not null,
	constraint pk_ingresos primary key (id),
	constraint fk_inoc_ingr foreign key(id_ingresos_ocasionales) references proyecto.ingresos_ocasionales(id),
	constraint fk_user_ingr foreign key(id_user) references proyecto.system_user1(id)
);

create table proyecto.deudas(
	id int4 not null,
	nombre_deuda varchar(50) null,
	valor_deuda int null,
	numero_cuotas int null,
	interes int null,
	fecha_inicio date null,
	fecha_fin date null,
	constraint pk_deudas primary key(id)
);

create table proyecto.gastos(
	id int4 not null,
	id_user int4 not null,
	id_deudas int4 not null,
	nombre_gasto varchar(50) not null,
	valor_gasto int not null,
    total_gasto int not null,
	constraint pk_gastos_fijos primary key(id),
	constraint fk_user_gast foreign key(id_user) references proyecto.system_user1(id),
	constraint fk_deud_gast foreign key(id_deudas) references proyecto.deudas(id)
);

create table proyecto.ingresos_gastos(
	id int4 not null,
	id_ingresos int4 not null,
	id_gastos int4 not null,
	valance int not null,
	constraint pk_ingresos_gastos primary key(id),
	constraint fk_ingr_inga foreign key (id_ingresos) references proyecto.ingresos(id),
	constraint fk_gast_inga foreign key (id_gastos) references proyecto.gastos(id)
);

create table proyecto.usuario(
	id int4 not null,
	id_user int4 not null,
	nombres varchar (100) not null,
	apellidos varchar (100) not null,
	fecha_nacimiento date not null,
	edad int not null,
	estrato int not null,
	constraint pk_usuario primary key (id),
	constraint fk_user_usua foreign key (id_user) references proyecto.system_user1(id)
);

create table proyecto.calendario(
	id int4 not null,
	id_ingresos int4 not null,
	id_deudas int4 not null,
	fecha_pago_deuda date not null,
	fecha_cobro_nomina date not null,
	constraint pk_calendario primary key(id),
	constraint fk_ingr_cale foreign key(id_ingresos) references proyecto.ingresos(id),
	constraint fk_deud_cale foreign key(id_deudas) references proyecto.deudas(id)
);

create table proyecto.soportes(
	id int4 not null,
	id_ingresos_gastos int4 not null,
	id_calendario int4 not null,
	imagen_url varchar(1000) null,
	constraint pk_soportes primary key(id),
	constraint fk_inga_sopo foreign key(id_ingresos_gastos) references proyecto.ingresos_gastos(id),
	constraint fk_cale_sopo foreign key(id_calendario) references proyecto.calendario(id)
);

create table proyecto.ayuda(
	id int4 not null,
	id_user int4 not null,
	consejo varchar (500) not null,
	opinion varchar (500) null,
	constraint pk_ayuda primary key(id),
	constraint fk_user_ayud foreign key(id_user) references proyecto.system_user1(id)
);