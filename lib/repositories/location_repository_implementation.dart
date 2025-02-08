import 'package:swipezone/repositories/location_repository.dart';
import 'package:swipezone/repositories/models/categories.dart';
import 'package:swipezone/repositories/models/localization.dart';
import 'package:swipezone/repositories/models/location.dart';

class ILocationRepository implements LocationRepository {
  @override
  Future<List<Location>> getLocations() {
    return Future.value([
      Location(
        "Tour Eiffel",
        "La Tour Eiffel est un monument emblématique de Paris, construit en 1889.",
        null,
        null,
        "https://i.pinimg.com/originals/27/62/0e/27620ee1abacab77ef67abbab1ff298c.jpg",
        Categories.Tower,
        null,
        Localization("Champ de Mars, 5 Avenue Anatole France, 75007 Paris",
            48.8584, 2.2945),
      ),
      Location(
        "Louvre",
        "Le Louvre est le plus grand musée d'art du monde, abritant la Joconde.",
        null,
        null,
        "https://images.unsplash.com/photo-1565099824688-e93eb20fe622?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
        Categories.Museum,
        null,
        Localization("Rue de Rivoli, 75001 Paris", 48.8606, 2.3376),
      ),
      Location(
        "Cathédrale Notre-Dame",
        "La cathédrale gothique Notre-Dame est située sur l'île de la Cité.",
        null,
        null,
        "https://upload.wikimedia.org/wikipedia/commons/3/3e/Notre_Dame_de_Paris_Cath%C3%A9drale_Notre-Dame_de_Paris_%286094164096%29.jpg",
        Categories.Church,
        null,
        Localization("6 Parvis Notre-Dame - Pl. Jean-Paul II, 75004 Paris",
            48.8529, 2.3508),
      ),
      Location(
        "Arc de Triomphe",
        "Construit pour honorer les victoires de Napoléon, il est situé sur la place de l'Étoile.",
        null,
        null,
        "https://images.unsplash.com/photo-1509439581779-6298f75bf6e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
        Categories.HistoricalSite,
        null,
        Localization("Place Charles de Gaulle, 75008 Paris", 48.8738, 2.295),
      ),
      Location(
        "Sacré-Cœur",
        "La basilique du Sacré-Cœur est un symbole religieux de Montmartre.",
        null,
        null,
        "https://www.voyagesbernard.fr/wp-content/uploads/voyages-bernard-paris-2017-19.jpg",
        Categories.Church,
        null,
        Localization(
            "35 Rue du Chevalier de la Barre, 75018 Paris", 48.8867, 2.3431),
      ),
      Location(
        "Panthéon",
        "Le Panthéon est un mausolée pour les grandes figures françaises.",
        null,
        null,
        "https://image.freepik.com/photos-gratuite/pantheon-entoure-gens-sous-ciel-nuageux-pendant-coucher-du-soleil-paris-france_181624-8826.jpg",
        Categories.HistoricalSite,
        null,
        Localization("Place du Panthéon, 75005 Paris", 48.8462, 2.3449),
      ),
      Location(
        "Place de la Concorde",
        "La plus grande place de Paris, connue pour son obélisque et ses fontaines.",
        null,
        null,
        "https://media3.hemisgalerie.com/25895-thickbox_default/obelisque-place-de-la-concorde-paris-france.jpg",
        Categories.HistoricalSite,
        null,
        Localization("Place de la Concorde, 75008 Paris", 48.8656, 2.3212),
      ),
      Location(
        "Palais Garnier",
        "L'Opéra Garnier est une somptueuse salle de spectacle datant du XIXe siècle.",
        null,
        null,
        "https://media.gettyimages.com/id/541383746/fr/photo/opera-national-de-paris-or-palais-garnier-view-of-the-auditorium-during-the-preparation-of-a.jpg?s=612x612&w=0&k=20&c=Kxb280Mx2QsE9TPULqfLoJlGuneqcSwGHhakXdXcVdQ=",
        Categories.Museum,
        null,
        Localization("Place de l'Opéra, 75009 Paris", 48.8719, 2.3316),
      ),
      Location(
        "Jardin des Tuileries",
        "Le jardin des Tuileries est un jardin public historique situé près du Louvre.",
        null,
        null,
        "https://a.cdn-hotels.com/gdcs/production161/d1886/11cab0ff-9d0b-4fda-b9d8-6f5463e11d9f.jpg",
        Categories.Park,
        null,
        Localization("113 Rue de Rivoli, 75001 Paris", 48.8636, 2.3276),
      ),
      Location(
        "Pont Alexandre III",
        "Ce pont richement orné relie les Champs-Élysées et les Invalides.",
        null,
        null,
        "https://fotoloco.fr/wp-content/uploads/photos/large/image_888thum_d4d6e4dca96c15a1c9ca3f2d3bc8bd9a.jpg",
        Categories.HistoricalSite,
        null,
        Localization("Pont Alexandre III, 75008 Paris", 48.8654, 2.3131),
      ),
    ]);
  }
}

