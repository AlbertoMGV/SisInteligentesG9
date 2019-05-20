package es.deusto.ingenieria.si.sbc.serpientes;

import org.kie.api.KieServices;
import org.kie.api.logger.KieRuntimeLogger;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import es.deusto.ingenieria.si.sbc.serpientes.Serpiente.Caracteristica;
import es.deusto.ingenieria.si.sbc.serpientes.Serpiente.Colmillos;
import es.deusto.ingenieria.si.sbc.serpientes.Serpiente.Color;
import es.deusto.ingenieria.si.sbc.serpientes.Serpiente.Escamas;
import es.deusto.ingenieria.si.sbc.serpientes.Serpiente.Patron;
import es.deusto.ingenieria.si.sbc.serpientes.Serpiente.Tarea;

public class MecanismoInferencia {

	public static void main(String[] args) {
		//Se crean 5 instancias de Serpientes
		Serpiente serpiente1 = new Serpiente();
		serpiente1.setEjemplar("Ejemplar 1");
		serpiente1.setColmillos(Colmillos.FRONTALES_FIJOS);
		serpiente1.setFosetasLoreales(true);
		serpiente1.setLongitud(2.0d);
		//9 es a relación entre la longitud y el grosor
		serpiente1.setCircunferencia(serpiente1.getLongitud()/9);
		serpiente1.setEscamas(Escamas.SUAVES);
		serpiente1.setColor(Color.NO_DEFINIDO);
		serpiente1.setPatron(Patron.BANDAS_ROJO_AMARILLO_NEGRO);
		serpiente1.setTarea(Tarea.INICIO);
		
		Serpiente serpiente2 = new Serpiente();
		serpiente2.setEjemplar("Ejemplar 2");
		serpiente2.setColmillos(Colmillos.FRONTALES_DESPLEGABLES);		
		serpiente2.setLongitud(4.5d);
		serpiente2.setFosetasLoreales(false);
		//4 es a relación entre la longitud y el grosor
		serpiente2.setCircunferencia(serpiente2.getLongitud()/4);
		serpiente2.setEscamas(Escamas.AQUILLADAS);
		serpiente2.addCaracteristica(Caracteristica.FOSAS_NASALES_MUY_PROTUBERANTES);
		serpiente2.setColor(Color.MARRON_CLARO);
		serpiente2.setPatron(Patron.ROMBOS_MARRON_OSCURO);
		serpiente2.setTarea(Tarea.INICIO);
		
		Serpiente serpiente3 = new Serpiente();
		serpiente3.setEjemplar("Ejemplar 3");
		serpiente3.setColmillos(Colmillos.FRONTALES_DESPLEGABLES);		
		serpiente3.setLongitud(2.0d);
		serpiente3.setFosetasLoreales(true);
		//5 es a relación entre la longitud y el grosor
		serpiente3.setCircunferencia(serpiente3.getLongitud()/5);
		serpiente3.setEscamas(Escamas.SUAVES);		
		serpiente3.setColor(Color.MARRON);
		serpiente3.setPatron(Patron.BANDAS_MARRON_ORCURO);
		serpiente3.setTarea(Tarea.INICIO);
		
		Serpiente serpiente4 = new Serpiente();
		serpiente4.setEjemplar("Ejemplar 4");
		serpiente4.setColmillos(Colmillos.FRONTALES_DESPLEGABLES);		
		serpiente4.setLongitud(2.5d);
		//5 es a relación entre la longitud y el grosor
		serpiente4.setCircunferencia(serpiente4.getLongitud()/5);
		serpiente4.setEscamas(Escamas.AQUILLADAS);
		serpiente4.addCaracteristica(Caracteristica.ESCAMAS_COLA_CASCABEL);
		serpiente4.setColor(Color.MARRON);
		serpiente4.setPatron(Patron.BANDAS_MARRON_ORCURO);
		serpiente4.setTarea(Tarea.INICIO);
		
		Serpiente serpiente5 = new Serpiente();
		serpiente5.setEjemplar("Ejemplar 5");
		serpiente5.setColmillos(Colmillos.TRASEROS);		
		serpiente5.setLongitud(3.0d);
		serpiente5.setFosetasLoreales(false);
		//10 es a relación entre la longitud y el grosor
		serpiente5.setCircunferencia(serpiente5.getLongitud()/10);
		serpiente5.setEscamas(Escamas.SUAVES);
		serpiente5.addCaracteristica(Caracteristica.OJOS_REDONDOS_GRANDES);
		serpiente5.setColor(Color.VERDE);
		serpiente5.setPatron(Patron.COLOR_UNIFORME);
		serpiente5.setTarea(Tarea.INICIO);
		
		//Se muestra el contenido de los objetos antes del proceso de inferencia
		System.out.println("ANTES DEL PROCESO DE INFERENCIA");
		System.out.println("----- --- ------- -- ----------");
		System.out.println(serpiente1);
		System.out.println("\n" + serpiente2);
		System.out.println("\n" + serpiente3);
		System.out.println("\n" + serpiente4);
		System.out.println("\n" + serpiente5);
		
        // KieServices es la factoría para crear servicios KIE 
        KieServices kServices = KieServices.Factory.get();
        
        // Se crea un contenedor para la base de conocimiento a partir del KieServices
        KieContainer kContainer = kServices.getKieClasspathContainer();
        
        // Se crea una sesión KIE en el contenedor a partir del fichero de configuración  
        // META-INF/kmodule.xml.
        KieSession kSession = kContainer.newKieSession("serpientes-session");
        
        // Se configura el log del proceso de inferencia
        KieRuntimeLogger logger = kServices.getLoggers().newFileLogger(kSession, "./log/serpientes");
				
		//Se insertan los objetos en la KIE Session (Memoria de trabajo)
		kSession.insert(serpiente1);
		kSession.insert(serpiente2);
		kSession.insert(serpiente3);
		kSession.insert(serpiente4);
		kSession.insert(serpiente5);
		
		System.out.println("\n\nDURANTE EL PROCESO DE INFERENCIA");
		System.out.println("------- -- ------- -- ----------");

		//Se invoca al proceso de inferencia
		kSession.fireAllRules();
		
		//Se cierra el log
		logger.close();

		//Se muestra el contenido de los objetos depues del proceso de inferencia
		System.out.println("\n\nDESPUES DEL PROCESO DE INFERENCIA");
		System.out.println("------- --- ------- -- ----------");
		System.out.println(serpiente1);
		System.out.println("\n" + serpiente2);
		System.out.println("\n" + serpiente3);
		System.out.println("\n" + serpiente4);
		System.out.println("\n" + serpiente5);		
	}
}