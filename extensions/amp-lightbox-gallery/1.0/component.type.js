/**
 * Copyright 2021 The AMP HTML Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS-IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/** @externs */

/** @const */
var LightboxGalleryDef = {};

/**
 * @typedef {{
 *   children: (PreactDef.Renderable),
 *   onBeforeOpen: (function():void|undefined),
 *   onAfterOpen: (function():void|undefined),
 *   onAfterClose: (function():void|undefined),
 *   onViewGrid: (function():void|undefined),
 *   onToggleCaption: (function():void|undefined),
 *   render: (function():PreactDef.Renderable|undefined),
 * }}
 */
LightboxGalleryDef.Props;

/**
 * @typedef {{
 *   as: (string|undefined),
 *   children: (!PreactDef.Renderable),
 *   enableActivation: (boolean|undefined),
 *   onClick: (function(Event)|undefined),
 *   render: (function():PreactDef.Renderable),
 * }}
 */
LightboxGalleryDef.WithLightboxProps;

/**
 * @typedef {{
 *   deregister: (function(string):undefined),
 *   register: (function(string, Element):undefined),
 *   open: (function():undefined),
 * }}
 */
LightboxGalleryDef.ContextProps;
