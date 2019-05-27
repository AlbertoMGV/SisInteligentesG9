package com.albertomgv.proyecto5;

import java.util.ArrayList;
import java.util.List;

public class Pelicula {
	
	public enum Conductas {		
		ANTISOCIALES,
		INCIVICAS,
		ILEGALES,
		PERJU_DESARRO_PSICO,
		GRATE_ABUSO
	}
	
	public enum Practicas_Discri {		
		GENERO,
		ETNICO,
		SEXUAL
	}
	
	public enum Escenas {		
		VIOLENCIA_VERBAL,
		VIOLENCIA_FISICA,
		ANSIEDAD,
		MIEDO,
		DOLOR,
		TENSION_EMOCIONAL,
		DESNUDEZ,
		DIALOG_EROTICOS,
		CRUELDAD,
		INQUIETUD
	}
	
	public enum Lenguaje {		
		HIRIENTE,
		AGRADABLE
	}
	
	public enum Contenido {		
		FACIL_COMPRENSIBLE,
		PERJU_DESARR_PSICO,
		HABITUAL_ADULTOS
	}
	
	public enum Valores {		
		PEDAGOGICOS,
		SOCIALES,
		ESTIMULA_IMAGINACION,
		PROMUEVE_REFLEXION
	}
	
	public enum Apologia {		
		DROGAS,
		VIOLENCIA,
		CONDUCTAS_ANTISOCIALES,
		PRACTICAS_DISCRIMINATORIAS		
	}
	
	public enum Categoria {		
		INFANTIL,
		PORNOGRAFIA,
		ADULTOS
	}
	
	private String name = null;
	private Conductas conducta=null;
	private Practicas_Discri practica=null;
	private Escenas escena=null;
	private Lenguaje lenguaje=null;
	private Contenido cont=null;
	private Valores valores=null;
	private Apologia apologia=null;
	private Categoria categoria=null;
	
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the conducta
	 */
	public Conductas getConducta() {
		return conducta;
	}
	/**
	 * @param conducta the conducta to set
	 */
	public void setConducta(Conductas conducta) {
		this.conducta = conducta;
	}
	/**
	 * @return the practica
	 */
	public Practicas_Discri getPractica() {
		return practica;
	}
	/**
	 * @param practica the practica to set
	 */
	public void setPractica(Practicas_Discri practica) {
		this.practica = practica;
	}
	/**
	 * @return the escena
	 */
	public Escenas getEscena() {
		return escena;
	}
	/**
	 * @param escena the escena to set
	 */
	public void setEscena(Escenas escena) {
		this.escena = escena;
	}
	/**
	 * @return the lenguaje
	 */
	public Lenguaje getLenguaje() {
		return lenguaje;
	}
	/**
	 * @param lenguaje the lenguaje to set
	 */
	public void setLenguaje(Lenguaje lenguaje) {
		this.lenguaje = lenguaje;
	}
	/**
	 * @return the cont
	 */
	public Contenido getCont() {
		return cont;
	}
	/**
	 * @param cont the cont to set
	 */
	public void setCont(Contenido cont) {
		this.cont = cont;
	}
	/**
	 * @return the valores
	 */
	public Valores getValores() {
		return valores;
	}
	/**
	 * @param valores the valores to set
	 */
	public void setValores(Valores valores) {
		this.valores = valores;
	}
	/**
	 * @return the apologia
	 */
	public Apologia getApologia() {
		return apologia;
	}
	/**
	 * @param apologia the apologia to set
	 */
	public void setApologia(Apologia apologia) {
		this.apologia = apologia;
	}
	/**
	 * @return the categoria
	 */
	public Categoria getCategoria() {
		return categoria;
	}
	/**
	 * @param categoria the categoria to set
	 */
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}
	
	@Override
	public String toString() {
		return "Pelicula [conducta=" + conducta + ", practica=" + practica + ", escena=" + escena + ", lenguaje="
				+ lenguaje + ", cont=" + cont + ", valores=" + valores + ", apologia=" + apologia + ", categoria="
				+ categoria + "]";
	}
	
	

}
