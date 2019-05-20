package es.deusto.ingenieria.si.sbc.serpientes;

import java.util.ArrayList;
import java.util.List;

public class Serpiente {
	
	public enum Colmillos {		
		FRONTALES_DESPLEGABLES,
		FRONTALES_FIJOS,
		TRASEROS
	}
	
	public enum Forma {
		DELGADA,
		ROBUSTA,
	}
		
	public enum Medida {
		GRANDE,
		MEDIANA,
		SMALL
	}	
	
	public enum Color {
		MARRON,
		MARRON_CLARO,
		NO_DEFINIDO,
		VERDE
	}
	
	public enum Patron {		
		BANDAS_MARRON_ORCURO,
		BANDAS_ROJO_AMARILLO_NEGRO,
		COLOR_UNIFORME,
		HEXAGONOS_PALIDOS,
		MANCHAS,
		ROMBOS_MARRON_OSCURO,
	}
	
	public enum Escamas {
		AQUILLADAS,
		SUAVES
	}
	
	public enum Caracteristica {
		ESCAMAS_COLA_CASCABEL,
		FOSAS_NASALES_MUY_PROTUBERANTES,
		OJOS_REDONDOS_GRANDES
	}
		
	public enum Especie {
		BOOMSLANG,
		SERPIENTE_CABEZA_COBRE,
		SERPIENTE_CASCABEL,
		SERPIENTE_CORAL,
		SERPIENTE_RATONERA,
		VIBORA_GABBON,
		VIBORA_RINOCERONTE,
	}
	
	public enum Tarea {
		CARACTERISTICA_PECULIAR,
		COLMILLOS,
		COLOR_Y_PATRON,
		ESCAMAS,
		FIN,
		FOSETAS_LOREALES,
		INICIO,
		MEDIDA_Y_FORMA
	}
	
	//Constantes numericas
	public static double LONG_LIMITE_INF = 1.5d;
	public static double LONG_LIMITE_SUP = 3.0d;
	public static int RATIO_LONG_CIRCUNFERENCIA = 5;
	
	private String ejemplar = null;
	private Colmillos colmillos = null;
	private Boolean fosetasLoreales = null;
	private Color color = null;
	private Patron patron = null;
	private Escamas escamas = null;
	private List<Caracteristica> caracteristicas = new ArrayList<Caracteristica>();
	private Double longitud = 0.0d;
	private Double circunferencia = 0.0d;
	private Medida medida = null;
	private Forma forma = null;
	private Especie especie = null;
	
	private Tarea tarea = null;
	
	public String getEjemplar() {
		return ejemplar;
	}
	
	public void setEjemplar(String ejemplar) {
		this.ejemplar = ejemplar;
	}
	
	public Colmillos getColmillos() {
		return colmillos;
	}

	public void setColmillos(Colmillos colmillos) {
		this.colmillos = colmillos;
	}

	public Boolean getFosetasLoreales() {
		return fosetasLoreales;
	}

	public void setFosetasLoreales(Boolean fosetasLoreales) {
		this.fosetasLoreales = fosetasLoreales;
	}

	public Color getColor() {
		return color;
	}

	public void setColor(Color color) {
		this.color = color;
	}

	public Patron getPatron() {
		return patron;
	}

	public void setPatron(Patron patron) {
		this.patron = patron;
	}

	public Escamas getEscamas() {
		return escamas;
	}

	public void setEscamas(Escamas escamas) {
		this.escamas = escamas;
	}

	public List<Caracteristica> getCaracteristicas() {
		return caracteristicas;
	}
	
	public void addCaracteristica(Caracteristica caracteristica) {
		if (caracteristicas == null) {
			caracteristicas = new ArrayList<Caracteristica>();
		}
		
		if (!caracteristicas.contains(caracteristica)) {
			caracteristicas.add(caracteristica);
		}
	}	

	public Double getLongitud() {
		return longitud;
	}

	public void setLongitud(Double longitud) {
		this.longitud = longitud;
	}

	public Double getCircunferencia() {
		return circunferencia;
	}
	
	public void setCircunferencia(Double circunferencia) {
		this.circunferencia = circunferencia;
	}

	public Medida getMedida() {
		return medida;
	}

	public void setMedida(Medida medida) {
		this.medida = medida;
	}

	public Forma getForma() {
		return forma;
	}

	public void setForma(Forma forma) {
		this.forma = forma;
	}

	public Especie getEspecie() {
		return especie;
	}

	public void setEspecie(Especie especie) {
		this.especie = especie;
	}
	
	public Tarea getTarea() {
		return tarea;
	}

	public void setTarea(Tarea tarea) {
		this.tarea = tarea;
	}

	public String toString() {
		String result = "* " + ejemplar;
			
		if (especie != null) {
			result += ": " + especie.toString();
		} else {
			result += ": ESPECIE_DESCONOCIDA";
		}

		if (tarea != null) {
			result += "\n   - Tarea: " + tarea.toString();
		}		
		
		if (colmillos != null) {
			result += "\n   - Colmillos: " + colmillos.toString();
		}
		
		if (medida != null) {
			result += "\n   - Medida: " + medida.toString();
		} else if (longitud > 0.0d) {
			result += "\n   - Longitud: " + longitud + " pies";
		}

		if (fosetasLoreales != null) {
			if (fosetasLoreales) {
				result += "\n   - Tiene fosetas loreales";
			} else {
				result += "\n   - NO tiene fosetas loreales";
			}
		}		
		
		if (forma != null) {
			result += "\n   - Forma: " + forma.toString();
		} else if (circunferencia > 0.0d){
			result += "\n   - Circunferencia: " + circunferencia + " pies";
		}		
		
		if (escamas != null) {
			result += "\n   - Escamas: " + escamas.toString();
		}
		
		result += "\n   - Caracteristicas peculiares: ";
		
		if (caracteristicas != null && !caracteristicas.isEmpty()) {
			for (Caracteristica caracteristica : caracteristicas) {
				result += caracteristica.toString() + ", ";
			}
		} else {
			result += "ninguna";
		}
		
		if (color != null) {
			result += "\n   - Color base: " + color.toString();
		}
		
		if (patron != null) {
			result += "\n   - Patron: " + patron.toString();
		} else {
			result += " (color uniforme)";
		}
		
		return result;
	}
}