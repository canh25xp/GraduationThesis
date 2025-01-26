# latexmkrc
$out_dir = "build";

# Fix generating of glossaries
# Source: https://github.com/overleaf/docker-image/issues/6#issuecomment-282931678
#add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
#sub makeglo2gls {
#    system("makeindex -s '$_[0]'.ist -t '$_[0]'.glg -o '$_[0]'.gls '$_[0]'.glo");
#}
#
#add_cus_dep('acn', 'acr', 0, 'makeacn2acr');
#sub makeacn2acr {
#    system("makeindex -s \"$_[0].ist\" -t \"$_[0].alg\" -o \"$_[0].acr\" \"$_[0].acn\"");
#}

#Source: https://tex.stackexchange.com/questions/631288/what-triggers-latexmk-to-invoke-makeglossaries
add_cus_dep( 'acn', 'acr', 0, 'run_makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'run_makeglossaries' );
add_cus_dep( 'ntn', 'not', 0, 'run_makeglossaries' );

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'ntn', 'not', 'nlg';

$clean_ext .= " acr acn alg glo gls glg ist not ntn";

sub run_makeglossaries {
    my $dir = dirname($_[0]);
    my $base_name = basename($_[0]);

    my $return;
    if ( $silent ) {
        $return = system "makeglossaries", "-q", "-d", "$dir", "$base_name";
    }
    else {
        $return = system "makeglossaries", "-d", "$dir", "$base_name";
    };
    return $return;
}
