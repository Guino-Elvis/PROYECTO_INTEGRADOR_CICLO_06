import React, { useState } from 'react';
import miImagen from '../../assets/images/logo.png';
import alumnoa from '../../styles/add.css';


const SSidenav = () => {
    const [isFullscreen, setFullscreen] = useState(false);

    const toggleFullscreen = () => {
        setFullscreen(!isFullscreen);
        document.documentElement.style.setProperty(
            '--screen-width',
            isFullscreen ? '100%' : '768px'
        );
        document.documentElement.style.setProperty(
            '--screen-height',
            isFullscreen ? '100%' : '1024px'
        );
        document.body.classList.toggle('mobile-style'); // Agregar o remover la clase 'mobile-style'
    };
    //togless
    const [isSubMenuOpen, setIsSubMenuOpen] = useState(false);
    const [isSubMenuAOpen, setIsSubMenuAOpen] = useState(false);
    const [isSidebarOpen, setIsSidebarOpen] = useState(true);

    const toggleSubMenu = () => {
        setIsSubMenuOpen(!isSubMenuOpen);
    };
    
    const toggleSubMenuA = () => {
        setIsSubMenuAOpen(!isSubMenuAOpen);
    };

    const toggleSidebar = () => {
        setIsSidebarOpen(!isSidebarOpen);
    };
    //end togless
    return (

        <div className=''>
            <span
                className="absolute text-blue text-4xl top-10 left-4 cursor-pointer ml-5"
                onClick={toggleSidebar}
            >
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
                </svg>
            </span>

            <aside className={` fixed  normal-case  bg-primary text-xs  leading-normal shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]              w-60 ease-nav-brand hover:overflow-y-auto  overflow-hidden z-990  inset-y-0 my-4 ml-4 block   flex-wrap items-center justify-between  rounded-2xl border-0 bg-white p-0 antialiased xl:left-0 xl:translate-x-0 ${isSidebarOpen ? "" : "hidden"
                }`}
            >

                <div class="h-20 ">
                    <div class="block absolute px-8 py-6 m-0 text-sm whitespace-nowrap "  >

                        <svg xmlns="http://www.w3.org/2000/svg" className="w-10 h-10 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path d="M12 14l9-5-9-5-9 5 9 5z" />
                            <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
                        </svg>

                    </div >
                    <button onClick={toggleSidebar} type='button' class="block xl:hidden bg-white relative px-8 py-6 m-0 text-sm whitespace-nowrap " >
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
                        </svg>
                    </button >
                </div>

                <hr class="h-px mt-0 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent" />

                <div class="items-center block w-auto max-h-screen  md:overscroll-contain  hover:overflow-auto overflow-hidden h-sidenav grow basis-full" >
                    <ul class="flex flex-col pl-0 mb-0">
                        <li class="mt-1 w-full">
                            <div class="mt-4  duration-400 hover:text-slate-300 bg-primary  pb-2 pt-2.5 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                <div onClick={toggleFullscreen} className={` ml-7 bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2
                                
                                ${isFullscreen ? 'clicked' : ''}`}
                                >
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-white">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5h3m-6.75 2.25h10.5a2.25 2.25 0 002.25-2.25v-15a2.25 2.25 0 00-2.25-2.25H6.75A2.25 2.25 0 004.5 4.5v15a2.25 2.25 0 002.25 2.25z" />
                                    </svg>


                                </div>
                                <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                    <svg width="32.57142857142856" height="24" viewBox="0 0 38 28" xmlns="http://www.w3.org/2000/svg" class="block mx-auto mb-1 fill-current  text-white"><path d="M34 26h4v1c-1.333.667-2.667 1-4 1H4c-1.333 0-2.667-.333-4-1v-1h4V7.5A1.5 1.5 0 0 1 5.5 6h27A1.5 1.5 0 0 1 34 7.5V26zM6 8v18h26V8H6z" fill-rule="evenodd"></path></svg>
                                </div>
                                <div onClick={toggleFullscreen} className={`  bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2
                                
                                ${isFullscreen ? 'clicked' : ''}`}
                                >
                                    <svg width="30.85714285714285" height="24" viewBox="0 0 36 28" xmlns="http://www.w3.org/2000/svg" class="block mx-auto mb-1 fill-current  text-white"><path d="M20.857 24l.857 3H24v1H12v-1h2.286l.857-3H1.5A1.5 1.5 0 0 1 0 22.5v-21A1.5 1.5 0 0 1 1.5 0h33A1.5 1.5 0 0 1 36 1.5v21a1.5 1.5 0 0 1-1.5 1.5H20.857zM2 2v18h32V2H2z"></path></svg>
                                </div>

                            </div>
                        </li>
                        {/* toggleSubMenu */}
                        <hr class="h-px mt-4 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent" />

                        <li class="mt-1 w-full">
                            <a href="/dashboard" class="mt-4 duration-400 hover:text-slate-300 bg-primary  pb-2 pt-2.5 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                    <svg fill='white' role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Fortinet</title><path d="M0 9.785h6.788v4.454H0zm8.666-6.33h6.668v4.453H8.666zm0 12.637h6.668v4.454H8.666zm8.522-6.307H24v4.454h-6.812zM2.792 3.455C1.372 3.814.265 5.404 0 7.425v.506h6.788V3.454zM0 16.091v.554c.24 1.926 1.276 3.466 2.624 3.9h4.188v-4.454zm24-8.184v-.506c-.265-1.998-1.372-3.587-2.792-3.972h-4.02v4.454H24zM21.376 20.57c1.324-.458 2.36-1.974 2.624-3.9v-.554h-6.812v4.454Z" /></svg>
                                </div>
                                <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Dashboard</span>
                            </a>
                        </li>

                        <hr class="h-px mt-4 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent" />

                        <div onClick={toggleSubMenu}
                            class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2.5 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                            <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                <svg fill='white' role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Databricks</title><path d="M.95 14.184L12 20.403l9.919-5.55v2.21L12 22.662l-10.484-5.96-.565.308v.77L12 24l11.05-6.218v-4.317l-.515-.309L12 19.118l-9.867-5.653v-2.21L12 16.805l11.05-6.218V6.32l-.515-.308L12 11.974 2.647 6.681 12 1.388l7.76 4.368.668-.411v-.566L12 0 .95 6.27v.72L12 13.207l9.919-5.55v2.26L12 15.52 1.516 9.56l-.565.308Z" /></svg>                                            </div>
                            <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Tables</span>
                            <span className="text-sm rotate-180 ml-20" id="arrow">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 15L12 18.75 15.75 15m-7.5-6L12 5.25 15.75 9" />
                                </svg>
                            </span>
                        </div>


                        <div
                            className={`text-left text-sm mt-2 w-4/5 ml-4 text-gray-200 font-bold ${isSubMenuOpen ? "" : "hidden"
                                }`}
                        >
                            <li class="mt-1 w-full">
                                <a href="/alumno" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Handshake</title><path d="M2.284 22.158c.001.95.679 1.752 1.62 1.792 1.31.055 2.623.022 3.935.022.954 0 1.786-.865 1.76-1.954-.029-1.221.018-2.445.029-3.667l.045-4.988c.003-.305.046-.362.335-.44a4.242 4.242 0 0 1 2.013-.067c1.23.262 2.129 1.21 2.261 2.46.066.62.07 1.249.078 1.874.025 1.64.038 3.28.054 4.921.01 1.087.796 1.877 1.883 1.882 1.171.006 2.342.008 3.513.007 1.106-.002 1.895-.778 1.898-1.883.007-3.371.007-6.742.01-10.113 0-.052 0-.105-.005-.156-.03-.355-.169-.658-.483-.838a2.638 2.638 0 0 0-.695-.291 7.484 7.484 0 0 0-2.887-.123c-.743.113-1.476.293-2.213.442-.97.196-1.946.28-2.934.178-1.268-.129-2.37-.666-3.402-1.38a32.36 32.36 0 0 0-1.494-.984c-.62-.38-1.314-.505-2.03-.544-.77-.043-1.536-.063-2.293.111-.59.136-.899.479-.966 1.077a3.438 3.438 0 0 0-.021.379m7.337-6.184a3.675 3.675 0 1 0-7.35-.031 3.675 3.675 0 0 0 7.35.03zm8.335-1.81a3.673 3.673 0 0 0-3.69 3.652 3.672 3.672 0 0 0 3.67 3.697 3.678 3.678 0 0 0 3.68-3.665 3.677 3.677 0 0 0-3.66-3.685Z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Alumnos</span>
                                </a>
                            </li>
                            <li class="mt-1 w-full">
                                <a href="/docentes" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg fill='white' xmlns="http://www.w3.org/2000/svg" height="2em" viewBox="0 0 640 512"><path d="M160 64c0-35.3 28.7-64 64-64H576c35.3 0 64 28.7 64 64V352c0 35.3-28.7 64-64 64H336.8c-11.8-25.5-29.9-47.5-52.4-64H384V320c0-17.7 14.3-32 32-32h64c17.7 0 32 14.3 32 32v32h64V64L224 64v49.1C205.2 102.2 183.3 96 160 96V64zm0 64a96 96 0 1 1 0 192 96 96 0 1 1 0-192zM133.3 352h53.3C260.3 352 320 411.7 320 485.3c0 14.7-11.9 26.7-26.7 26.7H26.7C11.9 512 0 500.1 0 485.3C0 411.7 59.7 352 133.3 352z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Docentes</span>
                                </a>
                            </li>
                            <li class="mt-1 w-full">
                                <a href="/cursos" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Asana</title><path d="M18.78 12.653c-2.882 0-5.22 2.336-5.22 5.22s2.338 5.22 5.22 5.22 5.22-2.34 5.22-5.22-2.336-5.22-5.22-5.22zm-13.56 0c-2.88 0-5.22 2.337-5.22 5.22s2.338 5.22 5.22 5.22 5.22-2.338 5.22-5.22-2.336-5.22-5.22-5.22zm12-6.525c0 2.883-2.337 5.22-5.22 5.22-2.882 0-5.22-2.337-5.22-5.22 0-2.88 2.338-5.22 5.22-5.22 2.883 0 5.22 2.34 5.22 5.22z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Cursos</span>
                                </a>
                            </li>
                            <li class="mt-1 w-full">
                                <a href="/inscripccion" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" viewBox="0 0 24 24" fill='white' xmlns="http://www.w3.org/2000/svg"><title>Read the Docs</title><path d="M7.732 0a59.316 59.316 0 0 0-4.977.218V24a62.933 62.933 0 0 1 3.619-.687c.17-.028.34-.053.509-.078.215-.033.43-.066.644-.096l.205-.03zm1.18.003V22.96a61.042 61.042 0 0 1 12.333-.213V1.485A60.859 60.859 0 0 0 8.912.003zm1.707 1.81a.59.59 0 0 1 .015 0c3.06.088 6.125.404 9.167.95a.59.59 0 0 1 .476.686.59.59 0 0 1-.569.484.59.59 0 0 1-.116-.009 60.622 60.622 0 0 0-8.992-.931.59.59 0 0 1-.573-.607.59.59 0 0 1 .592-.572zm-4.212.028a.59.59 0 0 1 .578.565.59.59 0 0 1-.564.614 59.74 59.74 0 0 0-2.355.144.59.59 0 0 1-.04.002.59.59 0 0 1-.595-.542.59.59 0 0 1 .54-.635c.8-.065 1.6-.114 2.401-.148a.59.59 0 0 1 .035 0zm4.202 2.834a.59.59 0 0 1 .015 0 61.6 61.6 0 0 1 9.167.8.59.59 0 0 1 .488.677.59.59 0 0 1-.602.494.59.59 0 0 1-.076-.006 60.376 60.376 0 0 0-8.99-.786.59.59 0 0 1-.584-.596.59.59 0 0 1 .582-.583zm-4.211.097a.59.59 0 0 1 .587.555.59.59 0 0 1-.554.622c-.786.046-1.572.107-2.356.184a.59.59 0 0 1-.04.003.59.59 0 0 1-.603-.533.59.59 0 0 1 .53-.644c.8-.078 1.599-.14 2.4-.187a.59.59 0 0 1 .036 0zM10.6 7.535a.59.59 0 0 1 .015 0c3.06-.013 6.125.204 9.167.65a.59.59 0 0 1 .498.67.59.59 0 0 1-.593.504.59.59 0 0 1-.076-.006 60.142 60.142 0 0 0-8.992-.638.59.59 0 0 1-.592-.588.59.59 0 0 1 .573-.592zm1.153 2.846a61.093 61.093 0 0 1 8.02.515.59.59 0 0 1 .509.66.59.59 0 0 1-.586.514.59.59 0 0 1-.076-.005 59.982 59.982 0 0 0-8.99-.492.59.59 0 0 1-.603-.577.59.59 0 0 1 .578-.603c.382-.008.765-.012 1.148-.012zm1.139 2.832a60.92 60.92 0 0 1 6.871.394.59.59 0 0 1 .52.652.59.59 0 0 1-.577.523.59.59 0 0 1-.076-.004 59.936 59.936 0 0 0-8.991-.344.59.59 0 0 1-.61-.568.59.59 0 0 1 .567-.611c.765-.028 1.53-.042 2.296-.042z" /></svg>

                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Inscripccion</span>
                                </a>
                            </li>
                            <li class="mt-1 w-full">
                                <a href="/asistencia" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Microsoft Academic</title><path d="M19.056 23.992c-4.018-2.966-10.695-8.022-19-9.125l3.55-3.472c10.19 3.935 15.45 12.597 15.45 12.597zM.48 18.437l2.77-2.217C11.334 18.208 18.19 24 18.19 24 15.303 22.37 7.113 18.36.48 18.437zm2.543-8.042l9.25-8.23 1.992 1.153L9.78 8.41c4.83 3.983 10.19 8.22 9.71 15.127C14.734 16.799 9.127 11.98 3.024 10.395zm7.907-2.131L18.035 0c3.791 3.1 5.91 7.913 5.91 10.513-.309 3.322-3.558 11.35-3.858 12.236-.225-2.007 1.434-5.56-9.157-14.485z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Asistencia</span>
                                </a>
                            </li>
                            <li class="mt-1 w-full">
                                <a href="/horarios" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Microsoft Academic</title><path d="M19.056 23.992c-4.018-2.966-10.695-8.022-19-9.125l3.55-3.472c10.19 3.935 15.45 12.597 15.45 12.597zM.48 18.437l2.77-2.217C11.334 18.208 18.19 24 18.19 24 15.303 22.37 7.113 18.36.48 18.437zm2.543-8.042l9.25-8.23 1.992 1.153L9.78 8.41c4.83 3.983 10.19 8.22 9.71 15.127C14.734 16.799 9.127 11.98 3.024 10.395zm7.907-2.131L18.035 0c3.791 3.1 5.91 7.913 5.91 10.513-.309 3.322-3.558 11.35-3.858 12.236-.225-2.007 1.434-5.56-9.157-14.485z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Horario</span>
                                </a>
                            </li>
                        </div>

                        <hr class="h-px mt-4 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent" />
                        {/* end toggleSubMenu */}

                        {/* toggleSubMenuA */}

                        <div onClick={toggleSubMenuA}
                            class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2.5 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                            <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                <svg fill='white' role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Databricks</title><path d="M.95 14.184L12 20.403l9.919-5.55v2.21L12 22.662l-10.484-5.96-.565.308v.77L12 24l11.05-6.218v-4.317l-.515-.309L12 19.118l-9.867-5.653v-2.21L12 16.805l11.05-6.218V6.32l-.515-.308L12 11.974 2.647 6.681 12 1.388l7.76 4.368.668-.411v-.566L12 0 .95 6.27v.72L12 13.207l9.919-5.55v2.26L12 15.52 1.516 9.56l-.565.308Z" /></svg>                                            </div>
                            <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Tables Pagina</span>
                            <span className="text-sm rotate-180 ml-10" id="arrow">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 15L12 18.75 15.75 15m-7.5-6L12 5.25 15.75 9" />
                                </svg>
                            </span>
                        </div>

                        <div
                            className={`text-left text-sm mt-2 w-4/5 ml-4 text-gray-200 font-bold ${isSubMenuAOpen ? "" : "hidden"
                                }`}
                        >

                            <li class="mt-1 w-full">
                                <a href="/slider" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Dolby</title><path d="M24,20.352V3.648H0v16.704H24z M18.433,5.806h2.736v12.387h-2.736c-2.839,0-5.214-2.767-5.214-6.194S15.594,5.806,18.433,5.806z M2.831,5.806h2.736c2.839,0,5.214,2.767,5.214,6.194s-2.374,6.194-5.214,6.194H2.831V5.806z" /></svg>

                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Slider</span>
                                </a>
                            </li>
                            <li class="mt-1 w-full">
                                <a href="/categoriablog" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>AWS Fargate</title><path d="M17.647 19.54v-2.28l1.412-.565v2.28Zm-2.353-2.845 1.412.565v2.28l-1.412-.564Zm-2.823 6.14v-2.281l1.411-.565v2.28Zm-2.353-2.846 1.411.565v2.28l-1.411-.564Zm-2.824-.449v-2.28l1.412-.565v2.28Zm-2.353-2.845 1.412.565v2.28l-1.412-.564Zm1.883-1.13L7.91 16l-1.086.434L5.737 16ZM12 18.86l1.086.434-1.086.434-1.086-.434Zm5.176-3.294 1.087.434-1.087.434L16.09 16Zm2.528-.003-2.353-.941a.476.476 0 0 0-.35 0l-2.352.94a.471.471 0 0 0-.296.438v2.787l-2.178-.871a.476.476 0 0 0-.35 0l-2.178.871V16a.471.471 0 0 0-.296-.437l-2.353-.941a.476.476 0 0 0-.35 0l-2.352.94A.471.471 0 0 0 4 16v3.294a.47.47 0 0 0 .296.437l2.353.941a.476.476 0 0 0 .35 0l2.177-.871v2.787c0 .193.118.365.296.437l2.353.942a.476.476 0 0 0 .35 0l2.353-.942a.471.471 0 0 0 .296-.437v-2.787l2.178.871a.476.476 0 0 0 .35 0l2.352-.94a.471.471 0 0 0 .296-.438V16a.471.471 0 0 0-.296-.437Zm4.06-5.71c0 2.75-6.06 4.235-11.764 4.235-5.703 0-11.765-1.484-11.765-4.235 0-1.313 1.457-2.47 4.101-3.256l.269.902C2.49 8.128 1.176 9.03 1.176 9.853c0 1.558 4.445 3.294 10.824 3.294s10.824-1.736 10.824-3.294c0-.823-1.314-1.725-3.429-2.354l.269-.902c2.644.787 4.1 1.943 4.1 3.256ZM12 .975l4.807 1.849L12 4.672 7.193 2.824Zm4.979 9.304c-.888.397-2.378.86-4.508.921V5.5l5.176-1.99v5.736c0 .448-.262.853-.668 1.033ZM6.353 9.246V3.51l5.176 1.99v5.7c-2.13-.062-3.62-.524-4.51-.922a1.126 1.126 0 0 1-.666-1.032Zm.284 1.891c1.036.464 2.807 1.017 5.363 1.017 2.556 0 4.327-.553 5.361-1.016a2.068 2.068 0 0 0 1.227-1.892V2.824c0-.195-.12-.37-.301-.44L12.169.031a.475.475 0 0 0-.338 0L5.713 2.384a.471.471 0 0 0-.301.44v6.422c0 .82.481 1.562 1.225 1.891Z" /></svg>                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Categoriablog</span>
                                </a>
                            </li>
                            <li class="mt-1 w-full">
                                <a href="/about" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" viewBox="0 0 24 24" fill='white' xmlns="http://www.w3.org/2000/svg"><title>Scala</title><path d="M4.589 24c4.537 0 13.81-1.516 14.821-3v-5.729c-.957 1.408-10.284 2.912-14.821 2.912V24zM4.589 16.365c4.537 0 13.81-1.516 14.821-3V7.636c-.957 1.408-10.284 2.912-14.821 2.912v5.817zM4.589 8.729c4.537 0 13.81-1.516 14.821-3V0C18.453 1.408 9.126 2.912 4.589 2.912v5.817z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">About</span>
                                </a>
                            </li>
                            <li class="mt-1 w-full">
                                <a href="/blog" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Geocaching</title><path d="M0 11.239h1.918c.151-1.738.841-3.819 2.521-5.498C2.81 4.532 2.484 3.136 2.484 2.36h.652c.068.682.357 1.656 2.247 2.753C7.167 4.067 7.532 3.037 7.631 2.36h.652c0 .721-.317 2.082-1.951 3.38 1.366.89 2.506 2.195 2.928 4.237H7.576c-.294-1.461-1.04-2.616-2.193-3.504-1.169 1.143-1.774 3.023-1.811 4.766h6.57V1.098H0v10.141zM5.383 2.63c.469 0 .85.377.85.842 0 .465-.38.841-.85.841a.846.846 0 0 1-.85-.841.847.847 0 0 1 .85-.842zM3.574 12.779h6.567v6.567a7.338 7.338 0 0 1-3.775-1.528L5.195 18.99a8.978 8.978 0 0 0 4.946 2.012v1.919H0V12.779h1.919a8.98 8.98 0 0 0 2.03 4.968l1.171-1.171a7.33 7.33 0 0 1-1.546-3.797zm8.108-11.681h10.142V11.24h-1.919a8.981 8.981 0 0 0-2.012-4.947l-1.171 1.171a7.338 7.338 0 0 1 1.528 3.776h-6.568V4.672a7.347 7.347 0 0 1 3.798 1.545l1.171-1.171a8.987 8.987 0 0 0-4.968-2.03V1.098zm0 11.681h10.142V22.92h-5.988l-1.172-4.736c.473-.572.965-.836 2.137-1.018 2.184-.341 2.576-2.232 2.576-2.232-1.02.245-1.837.001-2.799-.234-.949-.231-1.859-.211-2.727.092-.659.23-.818.445-.818.445l1.907 7.683h-3.257V12.779zm11.4-11.7a.894.894 0 0 0-.913.918c0 .521.392.913.913.913A.894.894 0 0 0 24 1.997a.895.895 0 0 0-.918-.918zm0 1.679a.738.738 0 0 1-.753-.761c0-.437.319-.764.753-.764.437 0 .759.327.759.764a.741.741 0 0 1-.759.761zm.379-.907c0-.201-.149-.298-.327-.298h-.411v.889h.204v-.309h.084l.259.309h.22v-.04l-.251-.28c.118-.028.222-.122.222-.271zm-.335.133h-.199v-.262h.199c.076 0 .133.044.133.131.001.081-.057.131-.133.131z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Blog</span>
                                </a>
                            </li>

                            <li class="mt-1 w-full">
                                <a href="/video" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Geocaching</title><path d="M0 11.239h1.918c.151-1.738.841-3.819 2.521-5.498C2.81 4.532 2.484 3.136 2.484 2.36h.652c.068.682.357 1.656 2.247 2.753C7.167 4.067 7.532 3.037 7.631 2.36h.652c0 .721-.317 2.082-1.951 3.38 1.366.89 2.506 2.195 2.928 4.237H7.576c-.294-1.461-1.04-2.616-2.193-3.504-1.169 1.143-1.774 3.023-1.811 4.766h6.57V1.098H0v10.141zM5.383 2.63c.469 0 .85.377.85.842 0 .465-.38.841-.85.841a.846.846 0 0 1-.85-.841.847.847 0 0 1 .85-.842zM3.574 12.779h6.567v6.567a7.338 7.338 0 0 1-3.775-1.528L5.195 18.99a8.978 8.978 0 0 0 4.946 2.012v1.919H0V12.779h1.919a8.98 8.98 0 0 0 2.03 4.968l1.171-1.171a7.33 7.33 0 0 1-1.546-3.797zm8.108-11.681h10.142V11.24h-1.919a8.981 8.981 0 0 0-2.012-4.947l-1.171 1.171a7.338 7.338 0 0 1 1.528 3.776h-6.568V4.672a7.347 7.347 0 0 1 3.798 1.545l1.171-1.171a8.987 8.987 0 0 0-4.968-2.03V1.098zm0 11.681h10.142V22.92h-5.988l-1.172-4.736c.473-.572.965-.836 2.137-1.018 2.184-.341 2.576-2.232 2.576-2.232-1.02.245-1.837.001-2.799-.234-.949-.231-1.859-.211-2.727.092-.659.23-.818.445-.818.445l1.907 7.683h-3.257V12.779zm11.4-11.7a.894.894 0 0 0-.913.918c0 .521.392.913.913.913A.894.894 0 0 0 24 1.997a.895.895 0 0 0-.918-.918zm0 1.679a.738.738 0 0 1-.753-.761c0-.437.319-.764.753-.764.437 0 .759.327.759.764a.741.741 0 0 1-.759.761zm.379-.907c0-.201-.149-.298-.327-.298h-.411v.889h.204v-.309h.084l.259.309h.22v-.04l-.251-.28c.118-.028.222-.122.222-.271zm-.335.133h-.199v-.262h.199c.076 0 .133.044.133.131.001.081-.057.131-.133.131z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Video</span>
                                </a>
                            </li>


                            <li class="mt-1 w-full">
                                <a href="/actividad" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Geocaching</title><path d="M0 11.239h1.918c.151-1.738.841-3.819 2.521-5.498C2.81 4.532 2.484 3.136 2.484 2.36h.652c.068.682.357 1.656 2.247 2.753C7.167 4.067 7.532 3.037 7.631 2.36h.652c0 .721-.317 2.082-1.951 3.38 1.366.89 2.506 2.195 2.928 4.237H7.576c-.294-1.461-1.04-2.616-2.193-3.504-1.169 1.143-1.774 3.023-1.811 4.766h6.57V1.098H0v10.141zM5.383 2.63c.469 0 .85.377.85.842 0 .465-.38.841-.85.841a.846.846 0 0 1-.85-.841.847.847 0 0 1 .85-.842zM3.574 12.779h6.567v6.567a7.338 7.338 0 0 1-3.775-1.528L5.195 18.99a8.978 8.978 0 0 0 4.946 2.012v1.919H0V12.779h1.919a8.98 8.98 0 0 0 2.03 4.968l1.171-1.171a7.33 7.33 0 0 1-1.546-3.797zm8.108-11.681h10.142V11.24h-1.919a8.981 8.981 0 0 0-2.012-4.947l-1.171 1.171a7.338 7.338 0 0 1 1.528 3.776h-6.568V4.672a7.347 7.347 0 0 1 3.798 1.545l1.171-1.171a8.987 8.987 0 0 0-4.968-2.03V1.098zm0 11.681h10.142V22.92h-5.988l-1.172-4.736c.473-.572.965-.836 2.137-1.018 2.184-.341 2.576-2.232 2.576-2.232-1.02.245-1.837.001-2.799-.234-.949-.231-1.859-.211-2.727.092-.659.23-.818.445-.818.445l1.907 7.683h-3.257V12.779zm11.4-11.7a.894.894 0 0 0-.913.918c0 .521.392.913.913.913A.894.894 0 0 0 24 1.997a.895.895 0 0 0-.918-.918zm0 1.679a.738.738 0 0 1-.753-.761c0-.437.319-.764.753-.764.437 0 .759.327.759.764a.741.741 0 0 1-.759.761zm.379-.907c0-.201-.149-.298-.327-.298h-.411v.889h.204v-.309h.084l.259.309h.22v-.04l-.251-.28c.118-.028.222-.122.222-.271zm-.335.133h-.199v-.262h.199c.076 0 .133.044.133.131.001.081-.057.131-.133.131z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Actividad</span>
                                </a>
                            </li>


                            <li class="mt-1 w-full">
                                <a href="/ubicacion" class="mt-4 hover:text-slate-300  bg-primary  pb-2 pt-2 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0  flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                    <div class="bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                        <svg role="img" fill='white' viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Geocaching</title><path d="M0 11.239h1.918c.151-1.738.841-3.819 2.521-5.498C2.81 4.532 2.484 3.136 2.484 2.36h.652c.068.682.357 1.656 2.247 2.753C7.167 4.067 7.532 3.037 7.631 2.36h.652c0 .721-.317 2.082-1.951 3.38 1.366.89 2.506 2.195 2.928 4.237H7.576c-.294-1.461-1.04-2.616-2.193-3.504-1.169 1.143-1.774 3.023-1.811 4.766h6.57V1.098H0v10.141zM5.383 2.63c.469 0 .85.377.85.842 0 .465-.38.841-.85.841a.846.846 0 0 1-.85-.841.847.847 0 0 1 .85-.842zM3.574 12.779h6.567v6.567a7.338 7.338 0 0 1-3.775-1.528L5.195 18.99a8.978 8.978 0 0 0 4.946 2.012v1.919H0V12.779h1.919a8.98 8.98 0 0 0 2.03 4.968l1.171-1.171a7.33 7.33 0 0 1-1.546-3.797zm8.108-11.681h10.142V11.24h-1.919a8.981 8.981 0 0 0-2.012-4.947l-1.171 1.171a7.338 7.338 0 0 1 1.528 3.776h-6.568V4.672a7.347 7.347 0 0 1 3.798 1.545l1.171-1.171a8.987 8.987 0 0 0-4.968-2.03V1.098zm0 11.681h10.142V22.92h-5.988l-1.172-4.736c.473-.572.965-.836 2.137-1.018 2.184-.341 2.576-2.232 2.576-2.232-1.02.245-1.837.001-2.799-.234-.949-.231-1.859-.211-2.727.092-.659.23-.818.445-.818.445l1.907 7.683h-3.257V12.779zm11.4-11.7a.894.894 0 0 0-.913.918c0 .521.392.913.913.913A.894.894 0 0 0 24 1.997a.895.895 0 0 0-.918-.918zm0 1.679a.738.738 0 0 1-.753-.761c0-.437.319-.764.753-.764.437 0 .759.327.759.764a.741.741 0 0 1-.759.761zm.379-.907c0-.201-.149-.298-.327-.298h-.411v.889h.204v-.309h.084l.259.309h.22v-.04l-.251-.28c.118-.028.222-.122.222-.271zm-.335.133h-.199v-.262h.199c.076 0 .133.044.133.131.001.081-.057.131-.133.131z" /></svg>
                                    </div>
                                    <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Ubicacion</span>
                                </a>
                            </li>


                        </div>

                        <hr class="h-px mt-4 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent" />
                        {/* end toggleSubMenuA */}


                        <li class="mt-1 w-full">
                            <a href="/alumno" class="mt-4 duration-400 hover:text-slate-300 bg-primary  pb-2 pt-2.5 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 ">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M21 7.5l-9-5.25L3 7.5m18 0l-9 5.25m9-5.25v9l-9 5.25M3 7.5l9 5.25M3 7.5v9l9 5.25m0-9v9" />
                                    </svg>

                                </div>
                                <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Dashboard</span>
                            </a>
                        </li>
                        <li class="mt-1 w-full">
                            <a href="/alumno" class="mt-4 duration-400 hover:text-slate-300 bg-primary  pb-2 pt-2.5 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                    SVG
                                </div>
                                <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Dashboard</span>
                            </a>
                        </li>

                        <li class="mt-1 w-full">
                            <a href="#" class="mt-4 duration-400 hover:text-slate-300 bg-primary  pb-2 pt-2.5 text-xs  normal-case leading-normal shadow-[0_4px_9px_-4px_#3b71ca]  ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]  py-2 shadow-soft-xl  ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap rounded-lg hover:bg-white px-4 font-semibold text-slate-700" >
                                <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2">
                                    SVG
                                </div>
                                <span class="ml-1   duration-300 opacity-100 pointer-events-none ease-soft">Realidad Virtual</span>
                            </a>
                        </li>


                        <hr class="h-px mt-4 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent" />

                        <li class="w-full mt-4">
                            <h6 class="pl-6 ml-2 text-xs font-bold leading-tight  normal-case opacity-60">Account pages</h6>
                        </li>

                        <li class="mt-1 w-full border-animation">
                            <a class="agg py-2  text-sm ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap px-4 transition-colors hover:bg-white" >
                                <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-gray-300 bg-center stroke-0 text-center xl:p-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill='white' height="1em" viewBox="0 0 448 512"><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z" /></svg>
                                </div>
                                <span class="ml-1 duration-300 opacity-100 pointer-events-none ease-soft normal-case">Mi Perfil</span>
                            </a>
                        </li>

                        <li class="mt-1 w-full">
                            <a class="py-2  text-sm ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap px-4 transition-colors hover:bg-white">
                                <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-gray-300 bg-center stroke-0 text-center xl:p-2 ">
                                    <svg xmlns="http://www.w3.org/2000/svg" height="1em" fill='white' viewBox="0 0 512 512"><path d="M217.9 105.9L340.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L217.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1L32 320c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM352 416l64 0c17.7 0 32-14.3 32-32l0-256c0-17.7-14.3-32-32-32l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32l64 0c53 0 96 43 96 96l0 256c0 53-43 96-96 96l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32z" /></svg>

                                </div>
                                <span class="ml-1 text-sm duration-300 pointer-events-none ease-soft normal-case">Sign In</span>
                            </a>
                        </li>

                        <li class="mt-1 w-full">
                            <a class="py-2  text-sm ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap px-4 transition-colors hover:bg-white" >
                                <div class=" bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500 shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-gray-300 bg-center stroke-0 text-center xl:p-2.5">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill='white' height="1em" viewBox="0 0 640 512"><path d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3zM504 312V248H440c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V136c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H552v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z" /></svg>

                                </div>
                                <span class="ml-1 duration-300 opacity-100 pointer-events-none ease-soft normal-case">Sign Up</span>
                            </a>
                        </li>
                    </ul>
                </div>


            </aside>
        </div>



    );
}

export default SSidenav;