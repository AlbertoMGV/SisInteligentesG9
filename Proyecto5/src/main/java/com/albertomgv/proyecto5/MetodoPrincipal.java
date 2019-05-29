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
		p1.setCategoria(Categoria.PORNOGRAFIA);
		p1.setValores(Valores.ESTIMULA_IMAGINACION);
		p1.setCriterios(Criterios.INICIO);
		
		Pelicula p2 = new Pelicula();
		p2.setName("Tetanic");
		p2.setEscena(Escenas.DESNUDEZ);
		p2.setCategoria(Categoria.PORNOGRAFIA);
		p2.setValores(Valores.ESTIMULA_IMAGINACION);
		p2.setCriterios(Criterios.INICIO);
		
		Pelicula p3 = new Pelicula();
		p3.setName("Tetanic");
		p3.setEscena(Escenas.DESNUDEZ);
		p3.setCategoria(Categoria.PORNOGRAFIA);
		p3.setValores(Valores.ESTIMULA_IMAGINACION);
		p3.setCriterios(Criterios.INICIO);
		
		Pelicula p4 = new Pelicula();
		p4.setName("Tetanic");
		p4.setEscena(Escenas.DESNUDEZ);
		p4.setCategoria(Categoria.PORNOGRAFIA);
		p4.setValores(Valores.ESTIMULA_IMAGINACION);
		p4.setCriterios(Criterios.INICIO);
		
		Pelicula p5 = new Pelicula();
		p5.setName("Tetanic");
		p5.setEscena(Escenas.DESNUDEZ);
		p5.setCategoria(Categoria.PORNOGRAFIA);
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
		
		System.out.println("\n\nDURANTE EL PROCESO DE INFERENCIA");
		System.out.println("------- -- ------- -- ----------");

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
