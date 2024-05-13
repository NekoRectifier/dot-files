/* eslint-disable no-invalid-this */
/* eslint-disable no-undef */
/* The above is for use of global in this file as Shell.global */
/* Gnome Shell Override
 *
 * Copyright (C) 2023 Sundeep Mediratta (smedius@gmail.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/* exported GnomeShellOverride */

const {Meta, Clutter, GObject} = imports.gi;

import {WorkspaceBackground} from 'resource:///org/gnome/shell/ui/workspace.js';
import {InjectionManager} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';

export {GnomeShellOverride};

var GnomeShellOverride = class {
    constructor() {
        this._injectionManager = new InjectionManager();
    }

    enable() {
        const Background = WorkspaceBackground;
        this._injectionManager.overrideMethod(Background.prototype, '_init',
            this._newBackgroundInit.bind(this));
    }

    disable() {
        this._injectionManager.clear();
    }

    _newBackgroundInit(origninalMethod) {
        return function (...args) {
            origninalMethod.call(this, ...args);
            const desktopWindows = global.get_window_actors().filter(a =>
                a.meta_window.get_window_type() === Meta.WindowType.DESKTOP);

            if (desktopWindows.length) {
                const desktopLayer = new Clutter.Actor({
                    layout_manager: new DesktopLayout(),
                    clip_to_allocation: true,
                });

                for (let windowActor of desktopWindows) {
                    const clone = new Clutter.Clone({
                        source: windowActor,
                    });

                    desktopLayer.add_child(clone);

                    windowActor.connectObject('destroy', () => {
                        clone.destroy();
                    }, this);
                }

                const syncAll = Clutter.BindConstraint.new(this._bgManager.backgroundActor, Clutter.BindCoordinate.ALL, 0);
                desktopLayer.add_constraint(syncAll);
                this._backgroundGroup.insert_child_above(desktopLayer, this._bgManager.backgroundActor);
            }
        };
    }
};

class DesktopLayout extends Clutter.LayoutManager {
    static {
        GObject.registerClass(this);
    }

    vfunc_get_preferred_width() {
        return [0, 0];
    }

    vfunc_get_preferred_height() {
        return [0, 0];
    }

    vfunc_allocate(container, box) {
        const monitor = Main.layoutManager.findIndexForActor(container);
        const workArea = Main.layoutManager.getWorkAreaForMonitor(monitor);
        const hscale = box.get_width() / workArea.width;
        const vscale = box.get_height() / workArea.height;

        for (const child of container) {
            const childBox = new Clutter.ActorBox();
            const frameRect = child.get_source()?.metaWindow.get_frame_rect();
            childBox.set_size(
                Math.round(Math.min(frameRect.width, workArea.width) * hscale),
                Math.round(Math.min(frameRect.height, workArea.height) * vscale));
            childBox.set_origin(
                Math.round(frameRect.x * hscale),
                Math.round(frameRect.y * vscale));
            child.allocate(childBox);
        }
    }
}
