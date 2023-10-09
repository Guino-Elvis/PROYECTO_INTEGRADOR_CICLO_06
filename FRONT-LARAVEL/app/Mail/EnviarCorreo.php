<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Attachment;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;


class EnviarCorreo extends Mailable
{
    use Queueable, SerializesModels;

    public $mensaje;
    public $adjunto;
    public $nombre;
    public $asunto;
    /**
     * Create a new message instance.
     */
    public function __construct($mensaje, $adjunto, $nombre,$asunto)
    {
        //
        $this->mensaje= $mensaje;
        $this->adjunto= $adjunto;
        $this->nombre = $nombre;
        $this->asunto = $asunto;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            // subject: $this->asunto . ' - Correo enviado',
            subject: $this->asunto ,
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'mails.enviar-correo',
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        if ($this->adjunto) {
       return [

        Attachment::fromData(fn () => $this->adjunto->get(), $this->adjunto->getClientOriginalName())
        ->withMime($this->adjunto->getMimeType())
        //   Attachment::fromData(fn () => $this->adjunto->get(), 'Reporte.pdf')->withMime('application/pdf')

        ];
    }
    return [];
    }
}
