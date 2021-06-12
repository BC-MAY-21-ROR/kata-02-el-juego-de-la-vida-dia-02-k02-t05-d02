# frozen_string_literal: true

class Kata
  # método inicializar clase
  def initialize(largo, ancho)
    @largo = largo
    @ancho = ancho
    @generacion = 1
    @grid = [] 
    @muertes =[]
    @vivas = []
  end

  def crearMatriz
    anchoReal = @ancho - 1
    largoReal= @largo-1
    @grid = Array.new(@largo) {Array.new(@ancho){[' * ', ' . '].sample}}
    (0..largoReal).each do |i|
      (0..anchoReal).each do |x|
        if i==0 || i==largoReal || x==0 || x==anchoReal
            @grid[i][x] =' . ' 
        end
      end
    end
  end

  def analizar_muertas
    copia=@grid
    (1..@largo - 2).each do |i|
        (1..@ancho - 2).each do |x|
          # Contar celulas vivas alrededor de cada punto
          celulas_vivas1 = 0
          celulas_vivas1 += 1 if copia[i - 1][x - 1] == ' * '
          celulas_vivas1 += 1 if copia[i - 1][x] == ' * '
          celulas_vivas1 += 1 if copia[i - 1][x + 1] == ' * '
          celulas_vivas1 += 1 if copia[i][x - 1] == ' * '
          celulas_vivas1 += 1 if copia[i][x + 1] == ' * '
          celulas_vivas1 += 1 if copia[i + 1][x - 1] == ' * '
          celulas_vivas1 += 1 if copia[i + 1][x] == ' * '
          celulas_vivas1 += 1 if copia[i + 1][x + 1] == ' * '
      
          # celula muerta con 3 vecinos vivos  revive
          @vivas.push([i , x]) if celulas_vivas1 == 3 && @grid[i][x] == ' . '
        end
      end

      vivas_tamano = @vivas.length
      (0..vivas_tamano-1).each do |y|
        coordenadaI = @vivas[y][0]
        coordenadaX = @vivas[y][1]
        @grid[coordenadaI][coordenadaX]=' * '
      end
  end


  def analizar_vivas
    copia=@grid
    (1..@largo - 2).each do |i|
        (1..@ancho - 2).each do |x|
          # Contar celulas vivas alrededor de cada punto
          celulas_vivas1 = 0
          celulas_vivas1 += 1 if copia[i - 1][x - 1] == ' * '
          celulas_vivas1 += 1 if copia[i - 1][x] == ' * '
          celulas_vivas1 += 1 if copia[i - 1][x + 1] == ' * '
          celulas_vivas1 += 1 if copia[i][x - 1] == ' * '
          celulas_vivas1 += 1 if copia[i][x + 1] == ' * '
          celulas_vivas1 += 1 if copia[i + 1][x - 1] == ' * '
          celulas_vivas1 += 1 if copia[i + 1][x] == ' * '
          celulas_vivas1 += 1 if copia[i + 1][x + 1] == ' * '
        
          # Condiciones
          # celula viva con mas de 3 vecinos vivos muere
          @muertes.push([i , x]) if celulas_vivas1 > 3 && @grid[i][x] == ' * '
          # celula viva con menor de dos vecinos vivos muere
          @muertes.push([i , x]) if celulas_vivas1 < 2 && @grid[i][x] == ' * '    
        end
    end
    muertes_tamano = @muertes.length
    (0..muertes_tamano-1).each do |y|
        coordenadaI = @muertes[y][0]
        coordenadaX = @muertes[y][1]
        @grid[coordenadaI][coordenadaX]=' . '
    end

  end

  def evolucionar
    @generacion+=1
    analizar_vivas()
    analizar_muertas()
  end

  def mostrar_matriz
    puts ' '
    puts  @generacion
    i = 0
    while i < @largo
      puts @grid[i].join(" ")
      i = i + 1
    end
  end
end

prueba = Kata.new(4,8)
prueba.crearMatriz
prueba.mostrar_matriz
prueba.evolucionar
prueba.mostrar_matriz