# Definisce la cartella dove vanno i file ausiliari (.aux, .log, .bbl, ecc.)
$aux_dir = '.temp';

# Definisce dove va il PDF finale (il punto '.' significa la directory corrente: Tesi/).
$pdf_dir = '.';

# Crea le sottodirectory necessarie per i file \include{} (es. .temp/sections/)
use File::Path qw(make_path);
make_path("$aux_dir/sections");