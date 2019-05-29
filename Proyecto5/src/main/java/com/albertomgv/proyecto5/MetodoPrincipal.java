package com.albertomgv.proyecto5;

import org.kie.api.KieServices;
import org.kie.api.logger.KieRuntimeLogger;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import com.albertomgv.proyecto5.Pelicula.Apologia;
import com.albertomgv.proyecto5.Pelicula.Categoria;
import com.albertomgv.proyecto5.Pelicula.Conductas;
import com.albertomgv.proyecto5.Pelicula.Contenido;
import com.albertomgv.proyecto5.Pelicula.Escenas;
import com.albertomgv.proyecto5.Pelicula.Lenguaje;
import com.albertomgv.proyecto5.Pelicula.Practicas_Discri;
import com.albertomgv.proyecto5.Pelicula.Valores;
import com.albertomgv.proyecto5.Pelicula.Criterios;

public class MetodoPrincipal {

	public static void main(String[] args) {
		
		//Creamos las peliculas con diferentes detalles
		
		Pelicula p1 = new Pelicula();
		p1.setName("Tetanic");
		p1.setEscena(Escenas.DESNUDEZ);
		p1.setConducta(Conductas.ILEGALES);
		p1.setPractica(Practicas_Discri.SEXUAL);
		p1.setLenguaje(Lenguaje.HIRIENTE);
		p1.setCont(Contenido.PERJU_DESARR_PSICO);
		p1.setApologia(Apologia.DROGAS);
		p1.setCategoria(Categoria.PORNOGRAFIA);
		p1.setValores(Valores.ESTIMULA_IMAGINACION);
		p1.setCriterios(Criterios.INICIO);
		
		Pelicula p2 = new Pelicula();
		p2.setName("Austin Powers");
		p2.setEscena(Escenas.DIALOG_EROTICOS);
		p2.setPractica(Practicas_Discri.ETNICO);
		p2.setLenguaje(Lenguaje.HIRIENTE);
		p2.setCont(Contenido.HABITUAL_ADULTOS);
		p2.setApologia(Apologia.DROGAS);
		p2.setCategoria(Categoria.ADULTOS);
		p2.setValores(Valores.SOCIALES);
		p2.setCriterios(Criterios.INICIO);
		
		Pelicula p3 = new Pelicula();
		p3.setName("FastandFurius");
		p3.setEscena(Escenas.INQUIETUD);
		p3.setLenguaje(Lenguaje.HIRIENTE);
		p3.setCont(Contenido.FACIL_COMPRENSIBLE);
		p3.setApologia(Apologia.VIOLENCIA);
		p3.setCategoria(Categoria.ADULTOS);
		p3.setValores(Valores.SOCIALES);
		p3.setCriterios(Criterios.INICIO);
		
		Pelicula p4 = new Pelicula();
		p4.setName("PeppaPig");
		p4.setLenguaje(Lenguaje.AGRADABLE);
		p4.setCont(Contenido.FACIL_COMPRENSIBLE);
		p4.setCategoria(Categoria.INFANTIL);
		p4.setValores(Valores.SOCIALES);
		p4.setCriterios(Criterios.INICIO);
		
		Pelicula p5 = new Pelicula();
		p5.setName("HarryPopoter");
		p5.setEscena(Escenas.TENSION_EMOCIONAL);
		p5.setLenguaje(Lenguaje.AGRADABLE);
		p5.setCont(Contenido.FACIL_COMPRENSIBLE);
		p5.setCategoria(Categoria.INFANTIL);
		p5.setValores(Valores.ESTIMULA_IMAGINACION);
		p5.setCriterios(Criterios.INICIO);
		
		//Mostramos la info de las peliculas antes del metodo
		
		System.out.println("ANTES DEL PROCESO DE INFERENCIA");
		System.out.println("----- --- ------- -- ----------");
		System.out.println(p1);
		System.out.println("\n" + p2);
		System.out.println("\n" + p3);
		System.out.println("\n" + p4);
		System.out.println("\n" + p5);
		
        // Instanciamos la factoria de kie
        KieServices kServices = KieServices.Factory.get();
        
        // Para almacenar el conocimiento
        KieContainer kContainer = kServices.getKieClasspathContainer();
        
        // Se crea una sesión KIE en el contenedor a partir del fichero de configuración  
        // META-INF/kmodule.xml.
        KieSession kSession = kContainer.newKieSession("peliculas_run");
        
        // Se configura el log del proceso de inferencia
        KieRuntimeLogger logger = kServices.getLoggers().newFileLogger(kSession, "./log/peliculas");
				
		//Se insertan los objetos en la KIE Session (Memoria de trabajo)
		kSession.insert(p1);
		kSession.insert(p2);
		kSession.insert(p3);
		kSession.insert(p4);
		kSession.insert(p5);
		
		//System.out.println("\n\nDURANTE EL PROCESO DE INFERENCIA");
		//System.out.println("------- -- ------- -- ----------");

		//Se invoca al proceso de inferencia
		kSession.fireAllRules();
		
		//Se cierra el log
		logger.close();

		//Se muestra el contenido de los objetos depues del proceso de inferencia
		System.out.println("\n\nDESPUES DEL PROCESO DE INFERENCIA");
		System.out.println("------- --- ------- -- ----------");
		System.out.println(p1);
		System.out.println("\n" + p2);
		System.out.println("\n" + p3);
		System.out.println("\n" + p4);
		System.out.println("\n" + p5);		

	}

}
