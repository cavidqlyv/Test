#include <iostream>
using namespace std;

//12


void main() {
	/*int a = 0, balans = 100, sifre = 0;
	cout << "sifreni daxil edin \n";
	cin >> sifre;
	if (sifre != 1234) { cout << "sifre sehvdi\n"; }
	else {


			cout << "size lazim olan meblegi daxil edin\n";
			cin >> a;
			if (a < 0) {cout<< "daxil etdiyiniz mebleg duz deyil\n"; }
			else
			if (a > 100) { cout << "hesabda lazimi qeder pul yoxdur\n"; }
			else if (a <= 100) {
				balans = 100 - a; cout << "hesabda qalan mebleg " << balans << "\n";

				int alma, corek, sigaret,mal;
				cout << " alma - 10 manat - almaq ucun 1 - basin\n corek - 15 manat - almaq ucun 2 - basin\n sigaret - sigaret - 20 - almaq ucun 3 - basin\n";
				cout << " alma ve corek almaq ucun 4 - basin\n alma ve sigaret almaq ucun 5 - basin\n corek ve sigaret almaq ucun 6 - basin\n her uc mehsulu almaq ucun 7 - basin\n";
				alma = 10;
				corek = 15;
				sigaret = 20;
				if (a < 10) { cout << "pulunuz catmir\n"; }

				else { cin >> mal;
				if (mal == 1|| mal == 2|| mal == 3 || mal==4|| mal == 5 || mal == 6 || mal == 7 ) {
					if (mal == 1) { if (a >= 10) cout << "alma aldiniz\n"; else cout << "pulunuz catmir\n"; }
					else if (mal == 2) { if (a >= 15)cout << "corek aldiniz\n"; else cout << "pulunuz catmir\n";
					}
					else if (mal == 3) { if (a >= 20) cout << "sigaret aldiniz\n"; else cout << "pulunuz catmir\n";
					}
					else if (mal == 4) { if (a >= 25) cout << "alma ve corek aldiniz\n"; else cout << "pulunuz catmir\n";
					}
					else if (mal == 5) { if (a >= 30) cout << "alma ve sigaret aldiniz\n"; else cout << "pulunuz catmir\n";
					}
					else if (mal == 6) { if (a >= 35) cout << "corek ve sigaret aldiniz\n"; else cout << "pulunuz catmir\n";
					}
					else if (mal == 7) { if (a >= 45) cout << "alma , corek ve sigaret aldiniz\n"; else cout << "pulunuz catmir\n";
					}
				}

				else { cout << "bele mal yoxdur\n"; }

				}




			}

	}*/

	int yas=0, esgerlik=0;
	cout << "yasi daxil edin\n";
	cin >> yas;
	if (yas < 0) { cout << "yasinizi duzgun daxil edin\n"; }
	else {
		if (yas <= 6) { cout << "siz usaq baxcasina gedirsiniz\n"; }
		else if (yas > 6 && yas < 18) { cout << "siz mektebe gedirsiniz\n"; }
		else if (yas == 18 && yas <24) {
			cout << "Universtete qebul olmusunuzsa 1 basin eks halda 2 basin\n";
			cin >> esgerlik;
			if (esgerlik == 1 || esgerlik == 2) {
				if (esgerlik = 1) { cout << "siz universtete gedirsiniz ve 23 yasinizda esgerliye gedeceysiniz\n"; }
				else { cout << "siz esgerliye gedirsiniz"; }
			}
			else cout << "Duzgun daxil et!";

		}
		else if (yas > 23 && yas <61) { cout << "Sizin islemek vaxtinizdir\n"; }
		else if (yas >= 60) { cout << "sizin pensiya vaxtinizdir\n"; }
	}

	
	/*int hava;
	cout << "havanin nece oldugunu daxil edin\n";
	cout << " hava kuleklidirse 1 basin\n hava yagislidirsa 2 basin \n kulek ve yaqis varsa 3 basin\n hec biri yoxdursa 4 basin\n";
	cin >> hava;
	if (hava == 1 || hava == 2 || hava == 3 || hava == 4) {
		if (hava == 1) { cout << "Papaq geyinmek lazimdir\n"; }
		else if (hava == 2) { cout << "cetir goturmek lazimdir\n"; }
		else if (hava == 3) { cout << "hem papaq geyinib hemde cetir goturmek lazimdir\n"; }
		else if (hava == 4) { cout << "hecne goturmek lazim deyil\n"; }

	}
	else cout << " duzgun daxil edin\n";*/
}
