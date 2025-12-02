<?php 
class Manusia{
    public $mulut;
    public $nama;
    public $umur;

    public function berbicara(){
        echo "Halo, nama saya " . $this->nama . " Saya sedang belajar di PPKD";
    }
}

$manusia = new Manusia();
$manusia ->nama ="Alan";
$manusia ->berbicara()

?>