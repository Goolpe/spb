import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'package:shelters/index.dart';

class MenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {    
    return Consumer<SettingsProvider>(
      builder: (context, settingsState, snapshot) {
        return Consumer<NavigationProvider>(
          builder: (context, navState, snapshot) {
            return Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SheltersMenuItem(
                        id: 0,
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: Theme.of(context).accentColor,
                          child: const Icon(MdiIcons.camera, size: 18, color: Colors.white)
                        ),
                        widget: ProfileScreen(),
                        icon: MdiIcons.faceProfile,
                        title: 'Arthur Khabirov',
                        subtitle: 'active status',
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SheltersMenuItem(
                              id: 1,
                              widget: AnimalsScreen(),
                              icon: MdiIcons.paw,
                              title: 'Pets',
                            ),
                            SheltersMenuItem(
                              id: 2,
                              widget: AddAnimalScreen(),
                              icon: MdiIcons.plus,
                              title: 'Add pet',
                            ),
                            SheltersMenuItem(
                              id: 3,
                              widget: ArticlesScreen(),
                              icon: MdiIcons.textBoxMultipleOutline,
                              title: 'Articles',
                            ),
                            SheltersMenuItem(
                              id: 4,
                              widget: MessagesScreen(),
                              icon: MdiIcons.forum,
                              title: 'Messages',
                            ),
                            // SheltersMenuItem(
                            //   id: 5,
                            //   widget: DonationScreen(),
                            //   icon: MdiIcons.handshake,
                            //   title: 'Donation',
                            // ),
                          ]
                        ),
                      ),
                      SheltersMenuItem(
                        id: 6,
                        widget: SettingsScreen(),
                        icon: MdiIcons.cog,
                        title: 'Settings'
                      ),
                    ]
                  ),
                  if(navState.prevId != null)
                    Positioned(
                      right: -(MediaQuery.of(context).size.width / 1.6),
                      child: _miniScreen(
                        tag: 'nav_${navState.prevId}',
                        widget: navState.prevWidget,
                        context: context,
                        height: 1.4,
                        overlay: true
                      )
                    ),
                  if(navState.activeId != null)
                    Positioned(
                      right: -(MediaQuery.of(context).size.width / 1.4),
                      child: _miniScreen(
                        tag: 'nav_${navState.activeId}',
                        widget: navState.activeWidget,
                        context: context,
                        height: 1.2,
                      )
                    ),
                ],
              ),
            );
          }
        );
      }
    );
  }

  Widget _miniScreen({
    @required String tag,
    @required Widget widget,
    @required BuildContext context,
    @required double height,
    bool overlay = false
  }){
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / height,
          width: MediaQuery.of(context).size.width,
          child: Hero(
            tag: tag,
            child: IgnorePointer(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: widget
              )
            )
          )
        ),
        if(overlay)
          Positioned.fill(
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
            ),
          )
      ],
    );
  }
}
